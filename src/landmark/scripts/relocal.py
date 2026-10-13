#!/usr/bin/env python3
import rospy
from std_msgs.msg import Bool
from std_msgs.msg import Int32
from std_msgs.msg import Empty
from std_msgs.msg import String
from md.msg import vel_msg
from geometry_msgs.msg import PoseWithCovarianceStamped
from nav_msgs.msg import Odometry
from landmark.msg import VisionCheckResult
from landmark.msg import VisionPose
from landmark.msg import relocal

import math
from math import pi

def diff(x1, y1, x2, y2):
    a = x2 - x1
    b = y2 - y1

    res = math.sqrt(a**2 + b**2)
    return res

def quaternion_to_euler(x,y,z,w):
    t0 = +2.0 * (w * x + y * z)
    t1 = +1.0 - 2.0 * (x * x + y * y)
    roll = math.atan2(t0, t1)
    t2 = +2.0 * (w * y - z * x)
    t2 = +1.0 if t2 > +1.0 else t2
    t2 = -1.0 if t2 < -1.0 else t2
    pitch = math.asin(t2)
    t3 = +2.0 * (w * z + x * y)
    t4 = +1.0 - 2.0 * (y * y + z * z)
    yaw = math.atan2(t3, t4)
    return [yaw, pitch, roll]


class relocalization():
    def __init__(self):
        self.move_status = True
        self.initialpose = PoseWithCovarianceStamped()
        self.amclPose_ = PoseWithCovarianceStamped()
        self.amclPose = PoseWithCovarianceStamped().pose.pose
        self.visionPose = PoseWithCovarianceStamped()
        self.vision_score = 1
        self.visionPoseList = []
        self.status = False
        self.cnt = 0
        self.cnt_frame = 0
        
        self.move_request = 0
        self.odomreset = False
        
        self.odom = Odometry()
        self.odom.pose.pose.position.x = 0
        self.odom.pose.pose.position.y = 0
        self.odom.pose.pose.orientation.z = 0
        self.odom.pose.pose.orientation.w = 1
        
        self.status_odom = False
        self.cnt_odom = 0
        
        self.move_stop_cnt = 0
        self.move_stop_cnt_ = 0
        self.move_stop = False        

        self.updateipose = True
        
        self.cnt_odomreset = 0
        
        self.systemState = False
        self.relocal_cnt = 0
        
        self.ReLocalType = 0 # 0 : 판단으로 인한 위치 재조정, 1: 판단 불가로 인한 위치 재조정
        
    def DriveStartCallback(self, data):
        self.systemState = True
        print(f'Drive Start, SystemState : {self.systemState}')
        
    def DriveCancelCallback(self, data):
        self.systemState = False
        print(f'Drive Cancel, SystemState : {self.systemState}')

    def amclPoseCallback(self, data):        
        if self.status:
            self.cnt_frame += 1
                        
            if self.amclPose == data.pose.pose:
                self.cnt += 1
            else:
                self.cnt = 0
        
        # amclPose는 계속 받아서 저장. 수렴을 판단하는 것만 특정 조건에서.    
        self.amclPose = data.pose.pose
        
    
    def VisionPoseCallback(self, data):
        # 위치 재조정 시스템 시작 부터 초기위치 발행 전까지 visionPose를 받아서 그 중 가장 적합한 추정 위치를 선택
        self.vision_score = data.score
        self.visionPose = data.vision_pose
        
        if self.systemState and not self.move_status and not self.odomreset and self.cnt_odomreset < 10: # odomreset 전까지 리스트에 추가. -> odomreset 후 선택
            self.visionPoseList.append([self.vision_score, self.visionPose])
            
    def moveStateCallback(self, data):
        self.move_request = data.data
        
            
    def moveState_Callback(self, data):
        if not self.move_status:
            if data.nLinear == 0 and data.nAngular == 0:
                self.move_stop_cnt += 1
                self.move_stop_cnt_ = 0
            else:
                self.move_stop_cnt = 0
                self.move_stop_cnt_ += 1
            
            if self.move_stop_cnt > 10:
                self.move_stop = True
            elif self.move_stop_cnt_ > 5:
                self.move_stop = False        
        
    
    def odomStateCallback(self, data):
        if self.status_odom:
            if self.odom.pose.pose == data.pose.pose:
                self.cnt_odom += 1
            else:
                self.cnt_odom = 0
            
            if self.cnt_odom > 10:
                # print('odom reset complete')
                self.odomreset = True
                self.cnt_odom = 0

    def VisionCheckCallback(self, data):
        self.move_status = data.move_status
        self.ReLocalType = data.ReLocalType
        self.initialpose = data.vision_pose
        self.amclPose_ = data.amcl_pose
        self.relocal_cnt += 1
        
        self.visionPoseList = [] # reset
        
        # 메시지 받았을 때도 기록, 정지 여부도 기록
        time_1 = int(rospy.get_time())
        if self.ReLocalType == 0:
            relocaltype = 'mismatch'
        else:
            relocaltype = 'unjudged'
        f = open('/home/nvidia/dconic_nav/src/landmark/scripts/relocal_log_726.txt', 'a')
        line = str(self.relocal_cnt) + '\t' + str(time_1) + '\t' + str(f'Received : Drive State False msg, Type : {relocaltype}') + '\n'
        f.write(line)
        f.close()


def main():
    rospy.init_node('relocal', anonymous=True)
    ic = relocalization()
       
    rospy.Subscriber('/vision_check_result', VisionCheckResult, ic.VisionCheckCallback, queue_size=1)
    rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, ic.amclPoseCallback, queue_size=1)
    
    # move_request를 받아서 조건으로 이용하자
    rospy.Subscriber('/move_request', Int32, ic.moveStateCallback, queue_size=1)
    rospy.Subscriber('/vel_topic', vel_msg, ic.moveState_Callback, queue_size=1)
    
    
    # Odom을 받아서 reset됐는지 확인
    rospy.Subscriber('/odom', Odometry, ic.odomStateCallback, queue_size = 1)
    
    # 주행취소를 눌렀을 때 relocal system이 멈추거나 reset되도록 하기
    rospy.Subscriber('/path_run_request', String, ic.DriveStartCallback, queue_size = 1)
    rospy.Subscriber('/path_run_cancel_request', Empty, ic.DriveCancelCallback, queue_size = 1)
    
    # VisionPose는 계속 받아서 위치 재조정 후 위치가 잘 잡혔는지 판단할 때 사용
    rospy.Subscriber('/vision_pose', VisionPose, ic.VisionPoseCallback, queue_size = 1)
    
    
    pub_move_request = rospy.Publisher('/move_request', Int32, queue_size = 1)
    pub_odom_reset = rospy.Publisher('/vel_topic', vel_msg, queue_size = 1)
    pub_initialpose = rospy.Publisher('/initialpose', PoseWithCovarianceStamped, queue_size = 1)
    pub_relocal_result = rospy.Publisher('/relocal_result', relocal, queue_size = 1)
    
    
    rate = rospy.Rate(1) 
    cnt_ros = 0
    cnt_again = 0
    
    while not rospy.is_shutdown():
        # 시스템 동작이 중지된 상태에서 주행 재개 시 시스템이 다시 동작되도록(리셋 후?)
        if not ic.systemState and ic.move_request == 2:
            print(f'system reset, system State : {ic.systemState}')
            # 리셋 후 동작 상태로?
            cnt_ros = 0
            cnt_again = 0
            ic.move_status = True
            ic.status = False
            ic.cnt = 0
            ic.cnt_frame = 0
            ic.move_request = 0
            ic.odomreset = False
            ic.status_odom = False
            ic.cnt_odom = 0
            ic.move_stop_cnt = 0
            ic.move_stop = False
            ic.updateipose = True
            ic.cnt_odomreset = 0           
            ic.visionPoseList = []
            
            
            ic.systemState = True
        
        # if not ic.systemState or (cnt_again >= 3 and ic.move_request == 1):  # 계속 초기위치 발행 시에 일시 정지를 눌러서 시스템을 멈추게 하려고 넣은 조건문
        if not ic.systemState or (cnt_again >= 3): # 초기위치 3번 발행 시 시스템 중지 -> 관리자가 직접 초기위치 발행해서 주행 재개하도록 함
            print(f'system reset, system State : {ic.systemState}')

            # 초기화
            cnt_ros = 0
            cnt_again = 0
            ic.move_status = True
            ic.status = False
            ic.cnt = 0
            ic.cnt_frame = 0
            ic.move_request = 0
            ic.odomreset = False
            ic.status_odom = False
            ic.cnt_odom = 0
            ic.move_stop_cnt = 0
            ic.move_stop = False
            ic.updateipose = True
            ic.cnt_odomreset = 0
            ic.visionPoseList = []           
            
        else:
        
            if ic.status:
                cnt_ros += 1
            
            # 주행 판단 결과가 False인 경우 move_request를 1로 발행 -> 주행 일시 정지 명령
            if not ic.move_status:
                
                # ic.relocal_cnt += 1

                
                if not ic.move_stop:            
                    print('Publish /move_request : 1')
                        
                    msg = Int32()
                    msg.data = 1
                    pub_move_request.publish(msg)
                
                # rospy.Rate(1).sleep() # 1초 후 정지했는지 확인
                else:
                # if ic.move_stop:
          
                    print('robot stop')

                    # # 주행 상태 판단 시스템 정지
                    # msg_ = Bool()
                    # msg_.data = False
                    # pub_visionsystem.publish(msg_)
                    # print('publish msg : vision-system pause')


                    # 로봇 정지 확인 했으니 odom reset 시작
                    rospy.Rate(5).sleep() # 0.2초 딜레이
                    
                    if not ic.status:
                        if ic.odomreset or ic.cnt_odomreset >= 10: # odomreset이 확인 되거나, odomreset 명령을 10번 내린 경우
                            if ic.cnt_odomreset >= 10:
                                print('odom-reset skip')
                                odomreset = False
                                time_delay = 1/2
                            else:
                                print('odom-reset complete')
                                odomreset = True
                                time_delay = 1/5
                            
                            print(f'select visionPose in List({len(ic.visionPoseList)})')
                            # 초기위치를 무엇으로 발행할지 선택
                            x1 = ic.initialpose.pose.pose.position.x
                            y1 = ic.initialpose.pose.pose.position.y
                            z1 = ic.initialpose.pose.pose.orientation.z
                            w1 = ic.initialpose.pose.pose.orientation.w
                            
                            min_score = 10000
                            for vpose in ic.visionPoseList:
                                score = vpose[0]
                                x = vpose[1].pose.pose.position.x
                                y = vpose[1].pose.pose.position.y
                                z = vpose[1].pose.pose.orientation.z
                                w = vpose[1].pose.pose.orientation.w
                                
                                diff_xy = diff(x,y,x1,y1)
                                ro1 = quaternion_to_euler(0,0,z,w)[0]*180/pi
                                ro2 = quaternion_to_euler(0,0,z1,w1)[0]*180/pi
                                rotate = round(abs(ro1-ro2), 3)
                                if rotate > 180:
                                    diff_rotate = 360-rotate
                                else:
                                    diff_rotate = rotate
                                if score < min_score and diff_xy < 1 and diff_rotate < 30:
                                    min_score = score
                                    x_ = x
                                    y_ = y
                                    z_ = z
                                    w_ = w                            
                            
                            if min_score < 150 and ic.ReLocalType == 0: # 판단 불가인 경우(ReLocalType == 1)에는 vpose를 신뢰할 수 없어서 보내준 initialpose를 사용
                                msg_ipose = ic.initialpose
                                msg_ipose.pose.pose.position.x = x_
                                msg_ipose.pose.pose.position.y = y_
                                msg_ipose.pose.pose.orientation.z = z_
                                msg_ipose.pose.pose.orientation.w = w_
                                select = 0
                            else:
                                msg_ipose = ic.initialpose
                                select = 1
                                
                            rospy.Rate(time_delay).sleep()
                            
                            # 초기위치 발행
                            # msg_ipose = ic.initialpose
                            # select = 'vpose'
                            pub_initialpose.publish(msg_ipose)
                            
                            print(f'publish initialpose with {select}, score : {min_score}')
                            
                            time_2 = int(rospy.get_time())
                            f = open('/home/nvidia/dconic_nav/src/landmark/scripts/relocal_log_726.txt', 'a')
                            line = str(ic.relocal_cnt) + '\t' + str(time_2) + '\t' + str(f'Robot Stop : {ic.move_stop}, Odom Reset : {odomreset}, InitialPose : {select}') + '\n'
                            f.write(line)
                            f.close()                            
                            
                            
                            # amcl 수렴 판단 시작
                            ic.status = True
                            
                            # odom 판단 중지
                            ic.status_odom = False
                            # odom 판단 결과 초기화
                            ic.odomreset = False
                            ic.cnt_odomreset = 0
                            # visionPoseList 초기화
                            ic.visionPoseList = []
                            print(f'reset visionPoseList, {len(ic.visionPoseList)}')
                            
                        else:
                            ic.cnt_odomreset += 1
                            
                            msg_odom = vel_msg()
                            msg_odom.byResetOdometry = 1
                            pub_odom_reset.publish(msg_odom)
                            
                            # 판단 시작
                            ic.status_odom = True
                            print('command odom reset')
                        
                    # amcl 수렴 및 초기 위치 적절 여부 확인 후 주행 재개
                    if ic.cnt > 10 or ic.cnt_frame > 200 or cnt_ros > 10:
                        print(f'set initialpose complete, ic.cnt(10) : {ic.cnt}, ic.cnt_frame(200) : {ic.cnt_frame}, cnt_ros(15) : {cnt_ros}')
                        # 이 시스템이 동작하는 동안 일시 정지 명령이 들어왔을 때 시스템 동작을 초기화 하기 위해서 여기서 move_request를 초기화 해줌
                        ic.move_request = 0
                        
                        
                        
                        x = round(ic.amclPose.position.x, 3)
                        y = round(ic.amclPose.position.y, 3)
                        z = round(ic.amclPose.orientation.z, 3)
                        w = round(ic.amclPose.orientation.w, 3)
                        
                        # x1 = ic.initialpose.pose.pose.position.x
                        # y1 = ic.initialpose.pose.pose.position.y
                        # z1 = ic.initialpose.pose.pose.orientation.z
                        # w1 = ic.initialpose.pose.pose.orientation.w
                        x1 = msg_ipose.pose.pose.position.x
                        y1 = msg_ipose.pose.pose.position.y
                        z1 = msg_ipose.pose.pose.orientation.z
                        w1 = msg_ipose.pose.pose.orientation.w
                        
                        x2 = round(ic.amclPose_.pose.pose.position.x, 3)
                        y2 = round(ic.amclPose_.pose.pose.position.y, 3)
                        z2 = round(ic.amclPose_.pose.pose.orientation.z, 3)
                        w2 = round(ic.amclPose_.pose.pose.orientation.w, 3)
                        
                        diff_xy = round(diff(x,y,x1,y1), 3)
                        ro1 = quaternion_to_euler(0,0,z,w)[0]*180/pi
                        ro2 = quaternion_to_euler(0,0,z1,w1)[0]*180/pi
                        rotate = round(abs(ro1-ro2), 3)
                        if rotate > 180:
                            diff_rotate = 360-rotate
                        else:
                            diff_rotate = rotate
                            
                        diff_xy_ = round(diff(x2,y2,x1,y1), 3)
                        ro1_ = quaternion_to_euler(0,0,z2,w2)[0]*180/pi
                        ro2_ = quaternion_to_euler(0,0,z1,w1)[0]*180/pi
                        rotate_ = round(abs(ro1_-ro2_), 3)
                        if rotate_ > 180:
                            diff_rotate_ = 360-rotate_
                        else:
                            diff_rotate_ = rotate_
                            
                        print(f'diff ipose and confirmed amcl : {diff_xy}, {diff_rotate}')
                        
                        
                        time = ic.initialpose.header.stamp.secs
                        ap_ = [x2, y2, 0.0, 0.0, 0.0, z2, w2]
                        vp = [x1, y1, 0.0, 0.0, 0.0, z1, w1]
                        ap = [x, y, 0.0, 0.0, 0.0, z, w]
                        
                        # if diff_xy < 1 and diff_rotate < 50:
                        if ic.ReLocalType == 0:
                            diff_xy_th = 2
                            diff_rotate_th = 50
                        else: # 판단 불가인 경우 기준이 좀 더 넓어야 함
                            diff_xy_th = 5
                            diff_rotate_th = 90
                        if diff_xy < diff_xy_th and diff_rotate < diff_rotate_th:
                            msg = Int32()
                            msg.data = 2
                            pub_move_request.publish(msg)
                            print('publish /move_request : 2')
                            
                            
                            '''
                            위치 재조정 관련 정보 기록
                            1. 주행 상태 False 판단 시간, amclPose, visionPose
                            2. odomreset 결과
                            3. 초기위치 발행 반복 횟수(기본 : 1)
                            4. 수렴된 amclPose, 초기위치와 수렴된 발행 위치와의 차이 -> 이걸 반복때마다 적는게 나은가? 위치 재조정에 번호 부여해서 하면 될 듯?
                            5. 주행 재개 성공 여부
                            
                            '''
                            time_ = int(rospy.get_time())
                            f = open('/home/nvidia/dconic_nav/src/landmark/scripts/relocal_log_726.txt', 'a')
                            line = str(ic.relocal_cnt) + '\t' + str(time) + '\t' + str(time_) + '\t' +  str(odomreset) + '\t' + str(cnt_again+1) + '\t' + str(ap_) + '\t' + str(vp) + '\t' + str(diff_xy_) + '\t' + str(diff_rotate_) + '\t' + str(ap) + '\t' + str(diff_xy) + '\t' + str(diff_rotate) + '\t' + str('Success') + '\n'
                            f.write(line)
                            f.close()
                            msg_relocal = relocal()
                            msg_relocal.count = ic.relocal_cnt
                            msg_relocal.time_start.secs = time
                            msg_relocal.time_end.secs = time_
                            msg_relocal.count_repeat = cnt_again+1
                            msg_relocal.odom_reset = odomreset
                            msg_relocal.visionPoseType = select
                            msg_relocal.amclPose = ap_
                            msg_relocal.initialPose = vp
                            msg_relocal.diff_xy = diff_xy_
                            msg_relocal.diff_rotate = diff_rotate_
                            msg_relocal.amclPose_relocal = ap
                            msg_relocal.diff_xy_relocal = diff_xy
                            msg_relocal.diff_rotate_relocal = diff_rotate
                            msg_relocal.relocal_result = True
                            pub_relocal_result.publish(msg_relocal)
                            
                            
                            # amcl 수렴 판단 멈춤
                            ic.status = False
                            ic.cnt = 0
                            ic.cnt_frame = 0
                            cnt_ros = 0
                            
                            cnt_again = 0
                            
                            # 시스템 종료
                            ic.move_status = True
                            ic.move_stop_cnt = 0
                            ic.move_stop = False
                            
                            
                        else:
                            # 초기위치 다시 발행
                            msg_ipose = ic.initialpose
                            pub_initialpose.publish(msg_ipose)
                            print('publish initialpose again')
                            
                            cnt_again += 1
                            time_ = int(rospy.get_time())
                            f = open('/home/nvidia/dconic_nav/src/landmark/scripts/relocal_log_726.txt', 'a')
                            line = str(ic.relocal_cnt) + '\t' + str(time) + '\t' + str(time_) + '\t' +  str(odomreset) + '\t' + str(cnt_again) + '\t' + str(ap_) + '\t' + str(vp) + '\t' + str(diff_xy_) + '\t' + str(diff_rotate_) + '\t' + str(ap) + '\t' + str(diff_xy) + '\t' + str(diff_rotate) + '\t' + str('Fail') + '\n'
                            f.write(line)
                            f.close()                            
                            
                            msg_relocal = relocal()
                            msg_relocal.count = ic.relocal_cnt
                            msg_relocal.time_start.secs = time
                            msg_relocal.time_end.secs = time_
                            msg_relocal.count_repeat = cnt_again
                            msg_relocal.odom_reset = odomreset
                            msg_relocal.visionPoseType = select
                            msg_relocal.amclPose = ap_
                            msg_relocal.initialPose = vp
                            msg_relocal.diff_xy = diff_xy_
                            msg_relocal.diff_rotate = diff_rotate_
                            msg_relocal.amclPose_relocal = ap
                            msg_relocal.diff_xy_relocal = diff_xy
                            msg_relocal.diff_rotate_relocal = diff_rotate
                            msg_relocal.relocal_result = False
                            pub_relocal_result.publish(msg_relocal)

                            ic.cnt = 0
                            ic.cnt_frame = 100
                            cnt_ros = 5
        
        rate.sleep()


if __name__ == '__main__':
    main()