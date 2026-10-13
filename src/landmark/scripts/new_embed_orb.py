#!/usr/bin/env python3
import rospy

import cv2
import numpy as np
import os
import pickle

from landmark.msg import des_vector
from std_msgs.msg import Bool

import math
from math import radians, degrees, pi, sin, cos
from collections import defaultdict

import heapq

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


def posemean(data):
    
    x = round(np.mean([x[0] for x in data]),3)
    y = round(np.mean([x[1] for x in data]), 3)
    z = round(np.mean([x[2] for x in data]), 3)
    x_ = round(np.mean([x[3] for x in data]), 3)
    y_ = round(np.mean([x[4] for x in data]), 3)
    
    z_sign = [-1, 1][sum([x[5] for x in data]) > 0] 
    z_ = z_sign * round(np.mean([abs(x[5]) for x in data]), 3)
    
    w_ = round(np.mean([x[6] for x in data]), 3)
    
    return [x, y, z, x_, y_, z_, w_]

def posemean2(list1, list2, alpha):
    
    x = round((list1[0]*(1-1/alpha)+list2[0]*(1/alpha)),3)
    y = round((list1[1]*(1-1/alpha)+list2[1]*(1/alpha)), 3)
    z = round((list1[2]*(1-1/alpha)+list2[2]*(1/alpha)), 3)
    x_ = round((list1[3]*(1-1/alpha)+list2[3]*(1/alpha)), 3)
    y_ = round((list1[4]*(1-1/alpha)+list2[4]*(1/alpha)), 3)
    
    z_sign = [-1, 1][list1[5] >= 0] 
    z_ = z_sign * round((abs(list1[5])*(1-1/alpha)+abs(list2[5])*(1/alpha)), 3)
    
    w_ = round((list1[6]*(1-1/alpha)+list2[6]*(1/alpha)), 3)
    
    return [x, y, z, x_, y_, z_, w_]

def findCosineDistance(source_representation, test_representation):
    a = np.matmul(np.transpose(source_representation), test_representation)
    b = np.sum(np.multiply(source_representation, source_representation))
    c = np.sum(np.multiply(test_representation, test_representation))
    return 1 - (a / (np.sqrt(b) * np.sqrt(c)))


class addembed():
    def __init__(self):
        # model
        self.bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
        # self.bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=False)
        
        # 0614
        index_params = dict(algorithm=6, table_number=6, key_size=12, multi_probe_level=1)
        search_params = dict(checks=32)
        self.flann = cv2.FlannBasedMatcher(index_params, search_params)
        
        # sub
        self.subscriber = rospy.Subscriber("/new_des_vector", des_vector, self.callback, queue_size = 1)
        self.path = rospy.get_param("~path_embed", "/home/nvidia/dconic_nav/src/landmark/scripts/dataset_feature/")
        self.embed_list = self.extract_embeds(self.path, 'orb_feature.pkl')
        
        # pub
        self.pub = rospy.Publisher('/db_update', Bool, queue_size = 1)        
        
        # -1 키 값에 저장해 둠
        if -1 not in self.embed_list.keys():
            self.cnt_embed = 0
        else:
            self.cnt_embed = self.embed_list[-1]
        
        # location_map
        self.path_map = rospy.get_param("~path_map", "/home/nvidia/dconic_nav/src/landmark/scripts/dataset_map/")
        self.map = self.extract_embeds(self.path_map, 'orb_map.pkl')

        self.th_sim = rospy.get_param("~th_sim", 100)
        self.call_cnt = 0

        self.xmin = int(rospy.get_param("~xmin", -150))
        self.ymin = int(rospy.get_param("~ymin", -150))
        self.xmax = int(rospy.get_param("~xmax", 150))
        self.ymax = int(rospy.get_param("~ymax", 150))
        self.unit = int(rospy.get_param("~unit", 10))
        
        # 후보 DB 불러오기
        self.path_temp = rospy.get_param("~path_temp", "/home/nvidia/dconic_nav/src/landmark/scripts/dataset_temp/")
        self.file_temp = os.path.join(self.path_temp, "orb_db_temp.pkl")
        self.file_temp_bak = os.path.join(self.path_temp, "orb_db_temp_bak.pkl")


        if os.path.isfile(self.file_temp):
            with open(self.file_temp, 'rb') as f:
                try:
                    self.db_temp = pickle.load(f)
                    with open(self.file_temp_bak, 'wb') as f:
                        pickle.dump(self.db_temp, f)
                except:
                    with open(self.file_temp_bak, 'rb') as f:
                        self.db_temp = pickle.load(f)

            
            '''
            1. embed_list_new : {group : {cnt_data : [embed, time]}}, 해당 번호의 임베딩 벡터와 시간정보
            2. map_new : {group : {cnt_data : [amclPose1, amclPose2, ,,,]}}, 해당 번호의 좌표 정보들
            3. cnt_map : {cnt_data : [count, group]}, 유사한 이미지 개수, 3개부터 데이터셋에 등록, 그룹 정보를 가지고 있음
            5. cnt : id라고 생각하면 됨. 이걸 key로 위의 정보들을 가져옴, 저장 시 후보 데이터셋의 최종 번호가 저장, 불러올 때 이 번호부터 이어서 시작하면 됨
            
            '''            
            self.embed_list_new = self.db_temp[0]
            self.map_new = self.db_temp[1]
            self.cnt_map = self.db_temp[2]
            self.cnt = self.db_temp[3]
        else:        
            self.embed_list_new = {}
            self.map_new = {}
            self.cnt_map = {}
            self.cnt = 0
    
    def extract_embeds(self, path, name):
        file_path = os.path.join(path, name)
        if os.path.isfile(file_path):
            with open(file_path, 'rb') as f:
                embed_list = pickle.load(f)        
                return embed_list
        else:
            embed_list = {}
            return embed_list
    
       
    def callback(self, data):
        self.call_cnt += 1
        new_data = False
        
        des = np.array(list(data.des)).reshape(data.count,32)
        des = des.astype(np.uint8)
        
        kp = np.array(list(data.kp)).reshape(-1, 2)
        
        
        x = round(data.pose.pose.pose.position.x, 3)
        y = round(data.pose.pose.pose.position.y, 3)
        z = round(data.pose.pose.pose.position.z, 3)

        x_ = round(data.pose.pose.pose.orientation.x, 3)
        y_ = round(data.pose.pose.pose.orientation.y, 3)
        z_ = round(data.pose.pose.pose.orientation.z, 3)
        w_ = round(data.pose.pose.pose.orientation.w, 3)
        
        amclPose = [x, y, z, x_, y_, z_, w_]

        time = data.pose.header.stamp.secs

        group_ = togroup(x, y, self.xmin, self.ymin, self.xmax, self.ymax, self.unit)
        # print('x, y :', x, y)
        # print('group :', group_)
        if group_ not in self.embed_list_new.keys():
            self.embed_list_new[group_] = defaultdict()
            self.map_new[group_] = defaultdict()        

        min_dist = 100000
        name = 0
        # 여기서 key가 데이터의 id(self.cnt)
        print(f'compare count: {len(self.embed_list_new[group_].keys())}')
        
        compared_keys = list(self.embed_list_new[group_].keys())[-500:]
        
        # for key in self.embed_list_new[group_].keys():
        for key in compared_keys:
            kp_ = self.embed_list_new[group_][key][0]
            # # BFMatcher
            # matches = self.bf.match(des, self.embed_list_new[group_][key][1])
            # matches = sorted(matches, key = lambda x:x.distance)
            # dist = 0
            # for match in matches[:10]: 
            #     # print(match)
            #     pt1 = kp[match.queryIdx]
            #     pt2 = kp_[match.trainIdx]
            #     dist += diff(pt1[0], pt1[1], pt2[0], pt2[1])            


            # Flann           
            matches = self.flann.knnMatch(des, self.embed_list_new[group_][key][1], k=1)
            matches = sorted([match for match in matches if match], key = lambda x:x[0].distance)
            dist = 0
            for match_ in matches[:10]: 
                match = match_[0]
                pt1 = kp[match.queryIdx]
                pt2 = kp_[match.trainIdx]
                dist += diff(pt1[0], pt1[1], pt2[0], pt2[1])      
                
                
            # BFMatcher, Flann
                     
            time_ = self.embed_list_new[group_][key][2]
            
            if dist < min_dist and (time-time_) > 10:
            # if dist < min_dist:
                name = key
                min_dist = dist
                
        
        print('name:', name, 'min_dist: ', min_dist)
                
        if min_dist > self.th_sim:
            self.cnt += 1
            # location_map
            self.map_new[group_][self.cnt] = [amclPose]
            # embed_list
            self.embed_list_new[group_][self.cnt] = [kp, des, time]
            self.cnt_map[self.cnt] = [1, group_] # 그룹 정보를 함께 넣음
            print('add new image, count: ', self.cnt)
        else:
            # 유사 이미지가 있는 경우 거리차이를 먼저 판단 -> 거리 차이가 크면 새로 등록, 아니면 좌표 쌓기
            # location_map
            # 거리차이 일정 거리 이내만 저장
            
            amclPose1 = self.map_new[group_][name][0]
            
            diff_x = abs(x-amclPose1[0])
            diff_y = abs(y-amclPose1[1])
            ro1 = quaternion_to_euler(amclPose1[-4], amclPose1[-3], amclPose1[-2], amclPose1[-1])[0]*180/pi
            ro2 = quaternion_to_euler(amclPose[-4], amclPose[-3], amclPose[-2], amclPose[-1])[0]*180/pi
            diff_rotate = round(abs(ro1-ro2), 4)
            if diff_x <= 1 and diff_y <= 1 and diff_rotate <= 15:
                self.embed_list_new[group_][name][2] = time # 시간 갱신
                self.map_new[group_][name].append(amclPose)            
                self.cnt_map[name][0] += 1
                print('add sim image, count: ', self.cnt_map[name][0])
            else: # 거리차이 만족 못하면 새로 추가
                self.cnt += 1
                self.map_new[group_][self.cnt] = [amclPose]
                self.embed_list_new[group_][self.cnt] = [kp, des, time]
                self.cnt_map[self.cnt] = [1, group_]
                print('diff X, add new image, count: ', self.cnt)
            
        # 일정 주기마다 하도록 하면? callback 실행 수를 세서 10번마다 실행하고 다시 0으로 초기화 이런식으로 하면 될 것 같기도 -> 60번으로 변경
        if self.call_cnt >= 60:
            self.call_cnt = 0 # 초기화

            # 데이터셋 후보에서 조건 만족하는 데이터 확정 데이터셋에 추가       
            # key 제거로 딕셔너리가 변할경우 list로 for문을 반복해줘야함       
            for key in list(self.cnt_map.keys()):
                # 후보 DB도 저장해서 누적 사용할 것이기 때문에, 최종 DB로 올리는 조건 횟수 3-> 5로 변경, 처음 DB 생성시에는 횟수 좀 낮춰야 함(3번으로?)
                if self.cnt_map[key][0] >= 3:
                    
                    group = self.cnt_map[key][1]
                    
                    self.cnt_embed += 1 # 이 번호를 최종 번호로 저장 -> -1 키 값에
                    self.embed_list[-1] = self.cnt_embed
                    
                    kp = self.embed_list_new[group][key][0] # keypoint
                    embed = self.embed_list_new[group][key][1] # time을 제외한 embed만 가져옴
                    time = self.embed_list_new[group][key][2]
                    
                    amclPose = posemean(self.map_new[group][key])
                    name = str(self.cnt_embed)
                    # 등록
                    # 여기서 등록 시간도 함께 저장 -> 나중에 DB 수정 시 활용 -> 기존 DB에 시간정보 추가해줘야 함
                    if group not in self.embed_list.keys():
                        self.embed_list[group] = [[kp, embed, name, time]]
                    else:
                        self.embed_list[group].append([kp, embed, name, time])
                    if group not in self.map.keys():
                        self.map[group] = defaultdict()
                    self.map[group][name] = amclPose

                    # 등록된 후보 DB 정보 제거
                    del self.cnt_map[key]
                    del self.embed_list_new[group][key]
                    del self.map_new[group][key]
                    
                    new_data = True
                    
                # 후보 DB 중 필요없는 데이터 자동 삭제하기 -> count가 1인 데이터 중, 최종 갱신 시간이 한참 전인 데이터
                elif self.cnt_map[key][0] == 1:
                    group = self.cnt_map[key][1]
                    time_ = self.embed_list_new[group][key][2]
                    # time -> 현재 시간
                    # 하루 -> 86400s -> 5일(432000) 동안 갱신되지 않은 후보 중 누적 횟수가 1인거 삭제? -> 3일로 변경(259200)
                    # if (time - time_) >  259200:
                    if (time - time_) >  86400:
                        
                        # 제거
                        del self.cnt_map[key]
                        del self.embed_list_new[group][key]
                        del self.map_new[group][key]
                    
                    
            # 데이터셋 후보 저장
            db_temp = [self.embed_list_new, self.map_new, self.cnt_map, self.cnt]
            with open(self.file_temp, 'wb') as f:
                pickle.dump(db_temp, f) 
        
        # 갱신된 정보 저장(매 순간) -> 이걸 추론 시에 매 순간 받아올 것인지 아니면 저장은 계속 하고 받아오는건 로봇을 재부팅 했을때만 할 것인지 고민
        # 저장을 계속 하고 있으니까 문제가 됨 -> 데이터 갱신이 있을 때 저장하도록 하자
        if new_data:            
            with open(os.path.join(self.path, 'orb_feature.pkl'), 'wb') as f:
                pickle.dump(self.embed_list, f)
            with open(os.path.join(self.path_map, 'orb_map.pkl'), 'wb') as f:
                pickle.dump(self.map, f)
                
            # 추론 쪽 데이터 셋 갱신을 위한 메시지 발행
            msg_db = Bool()
            msg_db.data = True
            self.pub.publish(msg_db)           
        
        
def main():
    rospy.init_node('dataset_update', anonymous=False)
    ic = addembed()
    
    # rospy.spin()
    
    rate = rospy.Rate(2)
    while not rospy.is_shutdown():
        rate.sleep()

if __name__ == '__main__':
    main()