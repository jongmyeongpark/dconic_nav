#!/usr/bin/env python3
import rospy

import cv2
import numpy as np
import time
import os
import pickle

from sensor_msgs.msg import Image
from std_msgs.msg import Bool
from std_msgs.msg import Int32
from std_msgs.msg import String
from std_msgs.msg import Empty

from geometry_msgs.msg import PoseWithCovarianceStamped
from landmark.msg import img_pose
from landmark.msg import img_pose_result
from landmark.msg import des_vector
from landmark.msg import VisionCheckResult
from landmark.msg import VisionPose

import math
from math import radians, degrees, pi, sin, cos
from collections import defaultdict


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

# new version
def togroup(x,y, xmin=-150, ymin=-150, xmax=150, ymax=150, unit=10):
    xrange = xmax - xmin
    yrange = ymax - ymin

    dx = xrange // unit
    dy = yrange // unit

    # 최소, 최대 만족하게
    # 최소를 1로 하는 이유는 0인 경우 나중에 -1에서 음수가 되기 때문
    x_ = max(min(x - xmin, xmax-xmin), 1)
    y_ = max(min(y - ymin, ymax-ymin), 1)
    
    

    x1 = ((x_-0.01) // unit) + 1
    y1 = ((y_-0.01) // unit)

    return x1 + y1*dx

# new version
def selectgroup(x,y, xmin, ymin, xmax, ymax, dist=2.5, unit=10):
    g_ = []
    for i in [-1, 0, 1]:
        for j in [-1, 0, 1]:
            g = togroup(x+(i*dist), y+(j*dist), xmin, ymin, xmax, ymax, unit=unit)
            g_.append(g)
            
    return list(set(g_))



class simcheck:
	def __init__(self):
		# model		
		self.num = int(rospy.get_param("~feature_num", 100))
		self.model_desc = cv2.ORB_create(self.num)
		self.model_match = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
  
		# 0614
		index_params = dict(algorithm=6, table_number=6, key_size=12, multi_probe_level=1)
		search_params = dict(checks=32)
		self.flann = cv2.FlannBasedMatcher(index_params, search_params)
      	
     	# config	
		self.th_sim = int(rospy.get_param("~th_sim", 100))
		self.th_error = int(rospy.get_param("~th_error", 100))
		self.th_unjudge = int(rospy.get_param("~th_unjudge", 500))

		self.xmin = int(rospy.get_param("~xmin", -150))
		self.ymin = int(rospy.get_param("~ymin", -150))
		self.xmax = int(rospy.get_param("~xmax", 150))
		self.ymax = int(rospy.get_param("~ymax", 150))
		self.unit = int(rospy.get_param("~unit", 10))

		# location_list
		self.path_embed = rospy.get_param("~path_embed", "/home/nvidia/dconic_nav/src/landmark/scripts/dataset_feature/")
		self.path_map = rospy.get_param("~path_map", "/home/nvidia/dconic_nav/src/landmark/scripts/dataset_map/")
		self.path_result = rospy.get_param("~path_result", "/home/nvidia/dconic_nav/src/landmark/scripts/")
		print(self.path_embed)
		print(self.path_map)
		self.embed_list_group = self.extract_pickle(self.path_embed, 'orb_feature.pkl')
		self.map_group = self.extract_pickle(self.path_map, 'orb_map.pkl')

		# DB_info
		self.path_info = rospy.get_param("~path_info", "/home/nvidia/dconic_nav/src/landmark/scripts/dataset_info/")
		self.db_info = self.extract_pickle(self.path_info, 'db_info.pkl')

    
    # subscriber
		self.subscriber = rospy.Subscriber("/image_pose", img_pose, self.callback, queue_size = 10)
		# self.sub_charge = rospy.Subscriber("/is_charging", Bool, self.isChargingCallback)
		self.sub_update = rospy.Subscriber("/db_update", Bool, self.dbupdateCallback)
		'''
  		주행을 통제하는 메시지를 받아서 주행 시작, 취소, 일시 정지, 재개에 따라 시스템 동작 여부 통제하기
		1. 일시 정지 : (move_request, 1) -> move_request로 1을 받으면 시스템 중지
		2. 주행 재개 : (move_request, 2) -> move_request로 2를 받으면 시스템 동작
		3. 주행 시작 : (path_run_request, csv파일) -> path_run_request가 발행되면 시스템 동작
		4. 주행 취소 : (path_run_cancel_request, empty) -> path_run_cancel_request가 발행되면 시스템 중지
		5. default는 중지 상태. 주행이 시작되면 메시지를 받아서 시스템이 시작. 주행 취소 및 일시 정지 시 callback에서 return 처리로 시스템 중지. 주행 재개 시 다시 동작하도록
		6. 시스템 동작 중지 시 errorcnt를 초기화 해야하는 경우 생각해보기
		'''
		self.sub_MoveRequest = rospy.Subscriber('/move_request', Int32, self.MoveRequestCallback, queue_size = 1)
		self.sub_DriveStart = rospy.Subscriber('/path_run_request', String, self.DriveStartCallback, queue_size = 1)
		self.sub_DriveCancel = rospy.Subscriber('/path_run_cancel_request', Empty, self.DriveCancelCallback, queue_size =1)


	# publisher
		self.result_pub = rospy.Publisher('/image_pose_result', img_pose_result, queue_size = 10)
		self.result_pub_embed = rospy.Publisher('/new_des_vector', des_vector, queue_size = 10)
		self.pub_driveState = rospy.Publisher('/vision_check_result', VisionCheckResult, queue_size=10)
		self.pub_vpose = rospy.Publisher('/vision_pose', VisionPose, queue_size=10)


		self.cnt = 0
  
	# status check
		self.times = []
		self.time_pre = 0
		self.cnt_time = 0
		self.status = 'Moving'
		self.score = 1
		self.new_pose = PoseWithCovarianceStamped()
   
		self.isCharging_ = False
  
		self.db_update = False
		self.cnt_callback = 0
  
	# 주행 상태 판단
		self.mismatch_cnt = 0
		self.systemState = False

	# 판단 불가 시 판단
		self.error_cnt = 0
		self.unjudge_cnt = 0
		self.th_unjudge_cnt = int(rospy.get_param("~th_unjudge_cnt", 10))
  
	# 서버로 보내는 데이터의 상태 추가
		self.valid_status = False
		self.mismatch_status = False
		self.relocal_status = 0 # 0: X, 1: 불일치, 2: 판단불가
		self.unjudge_status = False
  
	def MoveRequestCallback(self, data):
		if data.data == 1:
			self.systemState = False
			print(f'Drive Pause, SystemState : {self.systemState}')
		elif data.data == 2:
			self.systemState = True
			print(f'Drive restart, SystemState : {self.systemState}')
   
	def DriveStartCallback(self, data):
		self.systemState = True
		print(f'Drive Start, SystemState : {self.systemState}')
  
	def DriveCancelCallback(self, data):
		self.systemState = False
		print(f'Drive Cancel, SystemState : {self.systemState}')

	def isChargingCallback(self,data):
		self.isCharging_ = data.data

	def dbupdateCallback(self,data):
		self.db_update = data.data

	def extract_pickle(self, path, name):
		t1 = time.time()
		file_path = os.path.join(path, name) 
		if os.path.isfile(file_path):
			with open(file_path, 'rb') as f:
				extracted_list = pickle.load(f)
				t2 = time.time()        
				print('Extract pickle : Done', 'time :', t2-t1)        
				return extracted_list
		else:
			extracted_list = {}
			return extracted_list

	def callback(self, data):
		self.cnt_callback += 1
		# DB 갱신 시 새로 불러오기
		if self.db_update:
			self.embed_list_group = self.extract_pickle(self.path_embed, 'orb_feature.pkl')
			self.map_group = self.extract_pickle(self.path_map, 'orb_map.pkl')
			self.db_update = False
     
		# 6.12 CompressedImage
		np_arr = np.frombuffer(data.image.data, np.uint8)
		img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
		# img = np.frombuffer(data.image.data, dtype=np.uint8).reshape(data.image.height, data.image.width, -1)
		# gray로 바꿔줌
		img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
	
	# location - amcl
		x = round(data.pose.pose.pose.position.x, 3)
		y = round(data.pose.pose.pose.position.y, 3)
		z = round(data.pose.pose.pose.position.z, 3)

		x_ = round(data.pose.pose.pose.orientation.x, 3)
		y_ = round(data.pose.pose.pose.orientation.y, 3)
		z_ = round(data.pose.pose.pose.orientation.z, 3)
		w_ = round(data.pose.pose.pose.orientation.w, 3)
		
		info = [x, y, z, x_, y_, z_, w_]
		gt = info

	# status check
		# 시간이 멈추지 않도록 image.header에서 가져오기(amcl_pose는 멈춘경우 메시지 발행을 새로 안해서 time 갱신이 안됨)
		time = data.image.header.stamp.secs
		time_s = data.pose.header.stamp.secs
  
		if time_s == self.time_pre:
			self.cnt_time += 1
		else:
			self.cnt_time = 0
		self.time_pre = time_s
  
		if self.cnt_time >= 100:
			self.status = 'Stop'
		else:
			self.status = 'Moving'
   
		# for test
		# self.status = 'Moving'

 	# feature detect
		kp, des = self.model_desc.detectAndCompute(img, None)
		kp_list = np.array(list(sum([x.pt for x in kp], ())))

	# group
		xpoint = info[0]
		ypoint = info[1]
  
		dist_group = self.unit*0.25
		while_cnt = 0
  
		select_group = selectgroup(xpoint,ypoint, self.xmin, self.ymin, self.xmax, self.ymax, dist=dist_group, unit=self.unit)
		# print('select_group : ', select_group)
		# print('list_group : ', self.embed_list_group.keys())
		for group in select_group:
			if group in self.embed_list_group.keys():
				group_status = True
				break
			group_status = False
   
		while not group_status:
			while_cnt += 1
			dist_group += self.unit*0.25
			select_group = selectgroup(xpoint,ypoint, self.xmin, self.ymin, self.xmax, self.ymax, dist=dist_group, unit=self.unit)
			
			for group in select_group:
				if group in self.embed_list_group.keys():
					group_status = True
					break
				group_status = False

			if while_cnt > 10:
				break
		
		# 10번 돌렸는데도 DB에 group이 없음 -> 후보 DB에 보내야 함, 비교할 DB가 없으니 이대로 return
		if not group_status and self.status == 'Moving':
			embed = des.reshape(1, -1)[0]
			msg_embed = des_vector()
			msg_embed.count = des.shape[0]
			msg_embed.kp = kp_list
			msg_embed.des = embed
			msg_embed.pose = data.pose
			self.result_pub_embed.publish(msg_embed)
			print('pub new data_nogroup')
			return
			

		min_dist = 100000
		name = ''
		time_origin = 0
		for group in select_group:
			if group not in self.embed_list_group.keys():
				continue

			for value in self.embed_list_group[group][-500:]:
				des_ = value[1]
				kp_ = value[0]

				# # BFMatcher
				# matches = self.model_match.match(des, des_)
				# matches = sorted(matches, key = lambda x:x.distance)
				# dist = 0
				# for match in matches[:10]:
				# 	pt1 = kp[match.queryIdx].pt
				# 	pt2 = kp_[match.trainIdx]
				# 	dist += diff(pt1[0], pt1[1], pt2[0], pt2[1])

				# Flann
				matches = self.flann.knnMatch(des, des_, k=1)
				matches = sorted([match for match in matches if match], key = lambda x:x[0].distance)
				dist = 0
				for match_ in matches[:10]:
					match = match_[0]
					pt1 = kp[match.queryIdx].pt
					pt2 = kp_[match.trainIdx]
					dist += diff(pt1[0], pt1[1], pt2[0], pt2[1])

					


				if dist < min_dist:
					min_dist = dist
					name = value[2]
					time_origin = value[3]
					g = group

		if name == '': # 못찾은 경우 아무것도 안함
			print('no matching')
			return
  
		# image 기반으로 추정한 위치
		pr = self.map_group[g][name]
		# 현재 amcl_pose
		# gt = info
  
		# vpose 발행(이건 계속 발행 해야 함 or 위치 재조정이 시작되는 시점부터? 근데 결국 이걸 발행하려면 embed추출, DB와의 비교가 진행되어야 함)
		# 이걸 위치 재조정 시작(로봇 정지) 부터 받아서, 저장한다음 부여된 초기위치와 거리차이가 기준값을 만족하는 위치 중 score가 가장 낮은 vpose를 선택, 결정된 amcl과 비교
		# 이 때 거리차이를 1 or 2m 정도로(초기위치와 비교하는건 3m정도), 방향차이는 15-30?(초기위치와 비교는 50?)
		msg_vpose = VisionPose()
		msg_vpose.score = min_dist
		msg_vpose.vision_pose.header.stamp.secs = time
		msg_vpose.vision_pose.pose.pose.position.x = pr[0]
		msg_vpose.vision_pose.pose.pose.position.y = pr[1]
		msg_vpose.vision_pose.pose.pose.orientation.z = pr[-2]
		msg_vpose.vision_pose.pose.pose.orientation.w = pr[-1]
		self.pub_vpose.publish(msg_vpose)

		# 여기부터 패스하도록
		if not self.systemState:
			print('system pass')
			return


		diff_xy = round(diff(pr[0], pr[1], gt[0], gt[1]), 4)
		ro1 = quaternion_to_euler(pr[-4], pr[-3], pr[-2], pr[-1])[0]*180/pi
		ro2 = quaternion_to_euler(gt[-4], gt[-3], gt[-2], gt[-1])[0]*180/pi
		diff_rotate = round(abs(ro1-ro2), 4)
		if diff_rotate > 180:
			diff_rotate = 360 - diff_rotate

		# amcl 좌표와 비교
		if min_dist < self.th_sim:
			self.unjudge_cnt = 0 # 판단 가능한 경우 초기화
			self.valid_status = True # to server
			self.unjudge_status = False # 유효 판단의 경우 unjudge_status 는 항상 False
			if (diff_xy > 3 and diff_xy < 10) or diff_rotate > 15: # 아예 동떨어진 경우(diff_xy가 10이 넘는 경우)는 vpose가 잘못됐다고 판단 -> 에러로 판단 X
				self.mismatch_status = True
				self.mismatch_cnt += 1
				print(f'Error : {self.mismatch_cnt}')

				if min_dist < self.th_error:  # 불일치 결과 중에서 score가 100미만인 경우 error_cnt +1 -> 판단 불가 시 시나리오에 사용
					self.error_cnt += 1
     
     
     
     
			elif diff_xy <= 3 and diff_rotate <= 15: # diff_xy가 10보다 큰 경우 제외
				self.mismatch_status = False
				# 일치 시 count 초기화 
				# print('correct estimation, error count reset')
				self.mismatch_cnt = 0
				self.error_cnt = 0
				print('correct, error count reset')
			else: # diff_xy >= 10 and diff_rotate <= 15
				self.mismatch_status = False
    
				# # 위치재조정 시스템 테스트를 위해 여기도 초기화 X
				# print(f'correct estimation, error count : {self.mismatch_cnt}')
		elif min_dist > self.th_unjudge:
			self.valid_status = False
			self.mismatch_status = False
			if self.error_cnt > 0:
				self.unjudge_status = True # mismatch count가 1 이상인 경우에만 True -> error_cnt로 변경
				self.unjudge_cnt += 1 # 불일치가 1 이상인 상태에서 판단 불가인 경우 +1
				if self.error_cnt == 1:
					self.th_unjudge_cnt = 10
				else:
					self.th_unjudge_cnt = 5
			else:
				self.unjudge_status = False # mismatch count가 0인 경우에는 False
		else:
			self.valid_status = False
			self.mismatch_status = False
			self.unjudge_status = False # 중간의 경우에도 False
		# else:
			# 판단 못하는 경우도 초기화 -> 이 경우를 초기화 하는게 맞는지, 판단하지 못하는 경우에도 따로 장치를 둬야 하는건지 고민
			# 변수를 하나 더 만들어서 연속으로 판단 못하는 상황이 지속된다면 조치를 하는것도? 근데 아이가 계속 로봇앞에서 노이즈를 만드는 경우 주행상태는 괜찮지만 판단을 못하는
			# 상황이 발생할 수 있음. 이런 경우는 어떻게 제외?
			# print('cannot judge')
			# pass
			# if diff_xy > 1 or diff_rotate > 10:
			# 	print(f'cannot judge, but maybe error, no reset count : {self.mismatch_cnt}')
			# else:
			# 	self.mismatch_cnt = 0
			# 	print(f'cannot judge, but maybe correct, recet count : {self.mismatch_cnt}')

   
		# 3번 연속 틀리다고 판단한 경우, msg 발행 -> 오류에 의한 위치 재조정을 줄이기 위해 5번으로 수정
		# 주행 시작 지점은 제외
		if self.mismatch_cnt == 5:
			self.relocal_status = 1
			print('Drive State : False!, Re-localization start')
			msg = VisionCheckResult()
			msg.move_status = False
			msg.ReLocalType = 0
			msg.vision_pose.header.frame_id = 'map'
			msg.vision_pose.header.stamp.secs = time
			msg.vision_pose.pose.pose.position.x = pr[0]
			msg.vision_pose.pose.pose.position.y = pr[1]
			msg.vision_pose.pose.pose.orientation.z = pr[-2]
			msg.vision_pose.pose.pose.orientation.w = pr[-1]
			msg.vision_pose.pose.covariance = [0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.06853891909122467]
			msg.amcl_pose = data.pose
   
   
			self.pub_driveState.publish(msg)
   
			self.mismatch_cnt = 0
			self.error_cnt = 0
			self.unjudge_cnt = 0
		elif self.unjudge_cnt >= self.th_unjudge_cnt: 		# 판단 불가 시 시나리오
			self.relocal_status = 2
			msg_unjudge = VisionCheckResult()
			msg_unjudge.move_status = False
			msg_unjudge.ReLocalType = 1
			msg_unjudge.vision_pose.header.frame_id = 'map'
			msg_unjudge.vision_pose.header.stamp.secs = time
			msg_unjudge.vision_pose.pose.pose.position.x = gt[0]
			msg_unjudge.vision_pose.pose.pose.position.y = gt[1]
			msg_unjudge.vision_pose.pose.pose.orientation.z = gt[-2]
			msg_unjudge.vision_pose.pose.pose.orientation.w = gt[-1]
			msg_unjudge.vision_pose.pose.covariance = [0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.06853891909122467]
			msg_unjudge.amcl_pose = data.pose
			self.pub_driveState.publish(msg_unjudge)

			self.mismatch_cnt = 0
			self.error_cnt = 0
			self.unjudge_cnt = 0		
		else:
			self.relocal_status = 0


			# 이제 위치 재조정을 시작해야 하므로 주행 상태를 판단하는 것은 일시 정지 -> 이렇게 X
			# 위치 재조정 노드로부터 로봇이 정지했다는 정보를 받아서 정지 시키기
			# 정지 정보를 받기 전에 errorcnt가 쌓여서 메시지가 또 발행되면 위치 재조정 시스템이 꼬일 수 있음 -> 바로 일시 정지 시키는게 나은가?
			# 
			# self.systemState = False






		# save db_info
		# 마지막 선택 시간, 선택 횟수, 선택 시 거리, 방향 차이? or 선택시 방향,거리 차이에 따른 상태가 True였는지 False였는지를 각각 카운트?
		# 최종 DB 생성 시 생성 시간도 함께 저장하면 새롭게 생긴 DB를 필터링하는데 도움이 될 수 있을 듯 -> 기존 DB 형태 변경 필요(생성 시간 정보 추가)
		if min_dist < self.th_sim:
			if diff_xy < 3 and diff_rotate < 15:
				add_num = 1
			else:
				add_num = -1
			if g not in self.db_info.keys():
				self.db_info[g] = defaultdict()
			if name not in self.db_info[g].keys():
				# 첫 등록
				self.db_info[g][name] = [time, 1, add_num, time_origin]
			else:
				self.db_info[g][name][0] = time
				# 선택 횟수
				self.db_info[g][name][1] += 1
				# amcl과 비교, 선택 횟수 일정 이상에서 -값이라면 잘못된 데이터일 가능성 높음
				self.db_info[g][name][2] += add_num
    
			# 저장을 어떻게 할까? 매번?은 너무 비효율적이고
			# 1초마다 한번씩 실행되니 카운트 해서 일정 시간마다(1시간) 저장하는게 가장 나을 듯 ?
		if self.cnt_callback > 600:
			self.cnt_callback = 0
			with open(self.path_info+'db_info.pkl', 'wb') as f:
				pickle.dump(self.db_info, f)


		msg_result = img_pose_result()
		msg_result.stamp.secs = time
		msg_result.sim_id = int(name)
		msg_result.score = min_dist
		msg_result.amclPose = gt
		msg_result.visionPose = pr
		msg_result.diff_xy = diff_xy
		msg_result.diff_rotate = diff_rotate
		msg_result.valid_status = self.valid_status
		msg_result.mismatch_status = self.mismatch_status
		msg_result.unjudge_status = self.unjudge_status # unjudge status 추가
		msg_result.relocal_status = self.relocal_status

		# 충전 시에 메시지 발행 X
		if self.status == 'Moving': # 100초 이상 멈춰있는 경우는 제외(충전중일때 제외하려고함)
			self.result_pub.publish(msg_result)
			result_info_group = open(os.path.join(self.path_result, 'results_orb.txt'), 'a')
			self.cnt += 1
			line = str(self.cnt) + '\t' + name + '\t' + str(min_dist) + '\t' + str(self.map_group[g][name]) + '\t' + str(info) + '\t' + str(time) + '\t' + str(self.valid_status) + '\t' + str(self.mismatch_status) + '\t' + str(self.unjudge_status) + '\t' + str(self.relocal_status) + '\n'
			result_info_group.write(line)
			result_info_group.close()  
  
		# 매칭되지 않으면 후보 DB로 발행
		if min_dist > self.th_sim and self.status == 'Moving':
			embed = des.reshape(1, -1)[0]
			msg_embed = des_vector()
			msg_embed.count = des.shape[0]
			msg_embed.kp = kp_list
			msg_embed.des = embed
			msg_embed.pose = data.pose
			self.result_pub_embed.publish(msg_embed)
			print('publish new data')
      

def main():
	rospy.init_node('location_sim_checker', anonymous=False)
	checker = simcheck()
 
    # rospy.spin()
    
	rate = rospy.Rate(2)
	while not rospy.is_shutdown():
		rate.sleep()


if __name__ == '__main__':
	main()