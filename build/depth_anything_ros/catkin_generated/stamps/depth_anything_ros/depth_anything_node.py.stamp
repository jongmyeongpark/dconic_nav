#!/usr/bin/env python3

import rospy
import cv2
import numpy as np
import tensorrt as trt
import pycuda.driver as cuda
from sensor_msgs.msg import Image, PointCloud2, PointField
from cv_bridge import CvBridge

TRT_LOGGER = trt.Logger(trt.Logger.WARNING)


class DepthAnythingNode:
    def __init__(self):
        rospy.init_node('depth_anything_node')

        engine_path       = rospy.get_param('~engine_path')
        image_topic       = rospy.get_param('~image_topic', '/camera1/usb_cam1/image_raw')
        self.fx           = rospy.get_param('~fx', 600.0)
        self.fy           = rospy.get_param('~fy', 600.0)
        self.cx           = rospy.get_param('~cx', 320.0)
        self.cy           = rospy.get_param('~cy', 240.0)
        self.depth_scale  = rospy.get_param('~depth_scale', 1.0)
        self.min_depth    = rospy.get_param('~min_depth', 0.3)
        self.max_depth    = rospy.get_param('~max_depth', 4.0)
        self.input_h      = rospy.get_param('~input_height', 518)
        self.input_w      = rospy.get_param('~input_width', 518)
        self.point_stride = rospy.get_param('~point_stride', 4)
        self.frame_id     = rospy.get_param('~frame_id', 'usb_cam1')
        cloud_pub_rate    = rospy.get_param('~cloud_pub_rate', 1.5)

        # 이미지 행 기반 필터 (depth 정확도와 무관하게 동작)
        # top_skip_frac:    상단 N% 제거 → 천장 방향 노이즈 제거
        # bottom_keep_frac: 상단 N%까지만 사용 → 하단(바닥 반사) 제거
        self.top_skip_frac    = rospy.get_param('~top_skip_frac',    0.05)
        self.bottom_keep_frac = rospy.get_param('~bottom_keep_frac', 0.80)

        self._cloud_pub_interval = rospy.Duration(1.0 / cloud_pub_rate)
        self._last_cloud_pub     = rospy.Time(0)

        cuda.init()
        self.cuda_ctx = cuda.Device(0).make_context()

        self.bridge = CvBridge()
        self._load_engine(engine_path)

        self.pub           = rospy.Publisher('/depth_anything/pointcloud_raw', PointCloud2, queue_size=1)
        self.pub_depth     = rospy.Publisher('/depth_anything/depth_image',    Image,       queue_size=1)
        self.pub_depth_raw = rospy.Publisher('/depth_anything/depth_raw',      Image,       queue_size=1)
        rospy.Subscriber(image_topic, Image, self._callback, queue_size=1, buff_size=2**24)

        rospy.loginfo('[depth_anything] ready  stride=%d  rate=%.1fHz  row=%.0f%%~%.0f%%',
                      self.point_stride, cloud_pub_rate,
                      self.top_skip_frac * 100, self.bottom_keep_frac * 100)

    # ------------------------------------------------------------------ engine
    def _load_engine(self, path):
        with open(path, 'rb') as f, trt.Runtime(TRT_LOGGER) as runtime:
            self.engine = runtime.deserialize_cuda_engine(f.read())
        self.context = self.engine.create_execution_context()

        self.input_idx  = self.engine.get_binding_index('input')
        self.output_idx = self.engine.get_binding_index('identity_output')

        in_shape  = (1, 3, self.input_h, self.input_w)
        out_shape = (1, 1, self.input_h, self.input_w)

        self.h_input  = cuda.pagelocked_empty(int(np.prod(in_shape)),  dtype=np.float32)
        self.h_output = cuda.pagelocked_empty(int(np.prod(out_shape)), dtype=np.float32)
        self.d_input  = cuda.mem_alloc(self.h_input.nbytes)
        self.d_output = cuda.mem_alloc(self.h_output.nbytes)
        self.stream   = cuda.Stream()
        rospy.loginfo('[depth_anything] TensorRT engine loaded: %s', path)

    # ------------------------------------------------------------------ infer
    def _infer(self, img_rgb):
        resized = cv2.resize(img_rgb, (self.input_w, self.input_h))
        inp = resized.astype(np.float32) / 255.0
        inp = (inp - np.array([0.485, 0.456, 0.406], dtype=np.float32)) \
                   / np.array([0.229, 0.224, 0.225], dtype=np.float32)
        inp = inp.transpose(2, 0, 1)[np.newaxis]

        self.cuda_ctx.push()
        try:
            np.copyto(self.h_input, inp.ravel())
            cuda.memcpy_htod_async(self.d_input, self.h_input, self.stream)
            self.context.execute_async_v2(
                bindings=[int(self.d_input), int(self.d_output)],
                stream_handle=self.stream.handle)
            cuda.memcpy_dtoh_async(self.h_output, self.d_output, self.stream)
            self.stream.synchronize()
        finally:
            self.cuda_ctx.pop()

        return self.h_output.reshape(self.input_h, self.input_w)

    # ------------------------------------------------------- pointcloud builder
    def _depth_to_pointcloud(self, depth_map, orig_h, orig_w, header):
        depth_m = cv2.resize(depth_map, (orig_w, orig_h)) * self.depth_scale

        # 행 범위: 천장(상단) · 바닥(하단) 영역 제외
        row_top = int(orig_h * self.top_skip_frac)
        row_bot = int(orig_h * self.bottom_keep_frac)

        s = self.point_stride
        roi = depth_m[row_top:row_bot:s, ::s]

        valid = (roi > self.min_depth) & (roi < self.max_depth)
        yr, xr = np.where(valid)
        if len(yr) == 0:
            return None

        ys = yr * s + row_top
        xs = xr * s

        z = depth_m[ys, xs]
        x = (xs - self.cx) * z / self.fx
        y = (ys - self.cy) * z / self.fy

        points = np.stack([x, y, z], axis=-1).astype(np.float32)

        cloud = PointCloud2()
        cloud.header     = header
        cloud.height     = 1
        cloud.width      = len(points)
        cloud.fields     = [
            PointField('x', 0,  PointField.FLOAT32, 1),
            PointField('y', 4,  PointField.FLOAT32, 1),
            PointField('z', 8,  PointField.FLOAT32, 1),
        ]
        cloud.is_bigendian = False
        cloud.point_step   = 12
        cloud.row_step     = 12 * len(points)
        cloud.is_dense     = True
        cloud.data         = points.tobytes()
        return cloud

    # ----------------------------------------------------------------- callback
    def _callback(self, msg):
        now = rospy.Time.now()
        if (now - self._last_cloud_pub) < self._cloud_pub_interval:
            return  # 추론 건너뜀 → GPU/CPU 절약

        try:
            img_bgr = self.bridge.imgmsg_to_cv2(msg, 'bgr8')
        except Exception as e:
            rospy.logerr('[depth_anything] cv_bridge: %s', e)
            return

        depth_map = self._infer(cv2.cvtColor(img_bgr, cv2.COLOR_BGR2RGB))

        rospy.loginfo_throttle(3.0, '[depth_anything] depth min=%.3f max=%.3f mean=%.3f',
                               depth_map.min(), depth_map.max(), depth_map.mean())

        # depth 시각화 발행
        orig_h, orig_w = img_bgr.shape[:2]
        depth_resized = cv2.resize(depth_map, (orig_w, orig_h))

        # 32FC1 raw depth (실제 미터값, RViz에서 호버 시 수치 확인 가능)
        raw_msg = self.bridge.cv2_to_imgmsg(depth_resized.astype(np.float32), encoding='32FC1')
        raw_msg.header = msg.header
        self.pub_depth_raw.publish(raw_msg)

        # 컬러맵: 고정 범위 0~max_depth m (metric 모델이므로 색이 일정)
        depth_uint8 = (np.clip(depth_resized, 0, self.max_depth) / self.max_depth * 255).astype(np.uint8)
        vis = cv2.applyColorMap(depth_uint8, cv2.COLORMAP_INFERNO)
        dmsg = self.bridge.cv2_to_imgmsg(vis, encoding='bgr8')
        dmsg.header = msg.header
        self.pub_depth.publish(dmsg)

        cloud = self._depth_to_pointcloud(depth_map, orig_h, orig_w, msg.header)
        if cloud is not None:
            cloud.header.frame_id = self.frame_id
            cloud.header.stamp    = now
            self.pub.publish(cloud)
            self._last_cloud_pub = now
            rospy.loginfo_throttle(3.0, '[depth_anything] published %d pts', cloud.width)

    def __del__(self):
        try:
            self.cuda_ctx.pop()
        except Exception:
            pass


if __name__ == '__main__':
    try:
        node = DepthAnythingNode()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
