#!/usr/bin/env python

import threading
import rospy
import actionlib
import os	#sykim add
from smach import State,StateMachine
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from geometry_msgs.msg import PoseWithCovarianceStamped, PoseArray ,PointStamped
from std_msgs.msg import Empty, String, Int32
from tf import TransformListener
import tf
import math
import rospkg
import csv
import time
from actionlib_msgs.msg import GoalID

# mskim add
robot_pose = []
def PoseCallback(posedata):
    global robot_pose
    pose = posedata.pose
    robot_pose = [pose.pose.position.x, pose.pose.position.y]
    return robot_pose

repet_count = 0 # from user
repet_term = 0 # from user
repet = 1 # to count now
is_repet = False

keep_goal = MoveBaseGoal()
pause_state = -1
repet_count_keep = 0
repet_keep = 1
i_keep = 0
check_pause_state = 0

def PauseInit():
    global pause_state
    global repet_count_keep
    global repet_keep
    global i_keep
    global check_pause_state
    pause_state = -1
    repet_count_keep = 0
    repet_keep = 1
    i_keep = 0
    check_pause_state = 0
    
    rospy.loginfo("PauseInit!!\n")

def PathRepetCallback(path_repet):#20.12.03 dhjeon -add
    rospy.loginfo("PathRepetCallback function call!!\n")
    global repet_count
    global repet_term
    data = path_repet.data

    repet_count = int(data[0:2])
    repet_term = int(data[2:4])
    rospy.loginfo("path repet/time = %d %d", repet_count, repet_term)

    # 21.02.10 sykim add - pause reset
    #PauseInit()

    return repet_count

cancel = False 
def PathCancelCallback(path_run_cancel_request):
    rospy.loginfo("PathCancelCallback!!\n")
     # 21.02.09 sykim add - pause resetfinish_pub.publish
    PauseInit()
    global cancel
    cancel = True
    cancel_pub = rospy.Publisher('cancel_signal_from_fw', Empty, queue_size = 1)
    cancel_pub.publish(Empty())
   
# 21.02.05 sykim add - pause
def PauseCallback(pause_request):
    global pause_state
    global check_pause_state
    rospy.loginfo("PauseCallback!! pause_request = %d", pause_request.data)
    pause_state = pause_request.data

    # (pause_state => received pause_request (1:Pause 2:Go) ) 
    # (check_pause_state => 1: Pause, 0: Going)
    # received GO request
    if pause_state == 2:
        if check_pause_state == 1:
          cancel = False
          os.system('rostopic pub /start_journey std_msgs/Empty -1')
          check_pause_state = 0
        else:
          pause_state = -1

    rospy.loginfo("PauseCallback!! pause_state = %d", pause_state)
    rospy.loginfo('PauseCallback position (x,y): %s, %s' % (keep_goal.target_pose.pose.position.x, keep_goal.target_pose.pose.position.y))

# 21.04.06 sykim - check next goal
check_fail_plan = False
distance_data = 0.0
def FailPlanCallback(fail_plan):
    global check_fail_plan
    check_fail_plan = True
    rospy.loginfo("FailPlan Callback----")


#Path for saving and retreiving the pose.csv file 
output_file_path = rospkg.RosPack().get_path('follow_waypoints')+"/saved_path/pose.csv"
waypoints = []

class FollowPath(State):
    def __init__(self):
        State.__init__(self, outcomes=['success'], input_keys=['waypoints'])
        self.frame_id = rospy.get_param('~goal_frame_id','map')
        #odom frame-id modify, odom->odom_combined
        self.odom_frame_id = rospy.get_param('~odom_frame_id','odom_combined')
        self.base_frame_id = rospy.get_param('~base_frame_id','base_footprint')
        self.duration = rospy.get_param('~wait_duration', 0.0)
        # Get a move_base action client
        self.client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        rospy.loginfo('Connecting to move_base...')
        self.client.wait_for_server()
        rospy.loginfo('Connected to move_base.')
        #rospy.loginfo('Starting a tf listner.')
        self.tf = TransformListener()
        self.listener = tf.TransformListener()
        self.distance_tolerance = rospy.get_param('waypoint_distance_tolerance', 0.8) #generate next goal, if goal distance is lower then this parameter
        rospy.Subscriber('amcl_pose', PoseWithCovarianceStamped, PoseCallback)       
        rospy.Subscriber('path_run_cancel_request', Empty, PathCancelCallback) #dhjeon-21.01.05-add

        rospy.Subscriber('pause_request', Int32, PauseCallback) # 21.02.05 sykim add - pause
        rospy.Subscriber('/move_base/GlobalPlanner/fail_plan', Empty, FailPlanCallback) # 21.04.06 sykim - check next goal

    def execute(self, userdata):
        global waypoints
        global cancel
        global repet
        global repet_count
        start_pub = rospy.Publisher('drive_start_noti', Empty, queue_size = 1) #20.12.03 dhjeon -add
        start_pub.publish(Empty())
        #rospy.loginfo('start_pub.publish(Empty())')

        # 21.02.05 sykim add - pause
        global keep_goal
        global pause_state
        i = -1
        j = 0 #-1
        global repet_keep
        global repet_count_keep
        global i_keep
        global check_pause_state
        # 21.04.07 sykim - check next goal
        global check_fail_plan
        #distance_pub = rospy.Publisher('distance', Float32, queue_size = 1 )


        # Execute waypoints each in sequence
        for waypoint in waypoints:
            i = i+1
            rospy.loginfo('i j i_keep 1111 ^^^^^^^^^^^^^^^ %d %d %d', i, j, i_keep)
            if waypoints == []:
                rospy.loginfo('The waypoint queue has been reset.')
                break
            # sykim add
            os.system('rosservice call /move_base/clear_costmaps "{}" &')
            #os.system('rosservice call /request_nomotion_update "{}" &')
            
            # Otherwise publish next waypoint as goal
            goal = MoveBaseGoal()
            #goal.target_pose.header.frame_id = self.frame_id
            #goal.target_pose.pose.position = waypoint.pose.pose.position
            #goal.target_pose.pose.orientation = waypoint.pose.pose.orientation

            # 21.02.05 sykim add - pause
            keep_goal = goal
            rospy.loginfo('waypoint[%d]\n', i)
            rospy.loginfo('i j i_keep 2222 ^^^^^^^^^^^^^^^ %d %d %d', i, j, i_keep)

            current_waypoint_pub = rospy.Publisher('current_waypoint_from_fw', Int32, queue_size = 1) #21. 04. 06. jmlee -add
            current_waypoint_pub.publish(i)

            current_route_repetition_pub = rospy.Publisher('current_route_repetition_from_fw', Int32, queue_size = 1) #21. 09. 22. jmlee -add
            current_route_repetition_pub.publish(repet)
            
            if pause_state == 2: # restart
                if j<i_keep:
                    j = j+1
                    rospy.loginfo('j ^^^^^^^^^^^^^^^ %d', j)
                    continue
                else: # lets go
                    repet = repet_keep
                    repet_count = repet_count_keep
                    pause_state = -1
                check_pause_state = 0
            else:
                repet_count_keep = repet_count
                repet_keep = repet # always keep repet count now
                i_keep = i
                rospy.loginfo("&& i i_keep +++++++++++++++++ %d %d", i, i_keep)

            goal.target_pose.header.stamp = rospy.Time.now() # 21.03.31 dhjeon add
            goal.target_pose.header.frame_id = self.frame_id
            goal.target_pose.pose.position = waypoint.pose.pose.position
            goal.target_pose.pose.orientation = waypoint.pose.pose.orientation
            rospy.loginfo('Executing move_base goal to position (x,y): %s, %s' % (waypoint.pose.pose.position.x, waypoint.pose.pose.position.y))

            self.client.send_goal(goal)

            i_keep = i
            rospy.loginfo('i j i_keep 3333 ^^^^^^^^^^^^^^^ %d %d %d', i, j, i_keep)

            start_pub = rospy.Publisher('drive_start_noti', Empty, queue_size = 1) #21.04.06 jmlee -add
            start_pub.publish(Empty())

    	    #rospy.loginfo("i j i_keep +++++++++++++++++ %d %d %d", i, j, i_keep)
            if not self.distance_tolerance > 0.0:
                self.client.wait_for_result()
                rospy.loginfo("Waiting for %f sec..." % self.duration)
                time.sleep(self.duration)
            else:
                #This is the loop which exist when the robot is near a certain GOAL point.
                rospy.loginfo("robot is near GOAL point")
                rospy.loginfo("cancel *************** %s", cancel) # 21.03.16 sykim add test
                distance = 10

                # 21.04.06 sykim - check next goal
                time_flag = False
                pre_time = rospy.Time.now()
                while(distance > self.distance_tolerance):
                    now = rospy.Time.now()
                    self.listener.waitForTransform(self.odom_frame_id, self.base_frame_id, now, rospy.Duration(4.0))
                    trans,rot = self.listener.lookupTransform(self.odom_frame_id,self.base_frame_id, now)
                    #rospy.loginfo("distance : %f" % distance) #test log, mskim add

                    # 21.02.08 sykim add - pause
                    if pause_state == 1:
                        rospy.loginfo("in pause_state *************** %d", pause_state)
                        #os.system('rostopic pub -1 /move_base/cancel actionlib_msgs/GoalID -- {}')

                        # publish rostopic pub -1 /move_base/cancel actionlib_msgs/GoalID
                        # 21. 05. 06. jmlee -add
                        move_base_cancel_pub = rospy.Publisher('/move_base/cancel', GoalID, queue_size = 1) 
                        move_base_cancel_pub.publish(GoalID())

                        # pause_state = -1
                        repet_count_keep = repet_count
                        #rospy.loginfo("repet ============= %d", repet)
                        repet_keep = repet
                        cancel = True
                        rospy.loginfo('i ================ %d', i)
                        check_pause_state = 1
                        pause_pub = rospy.Publisher('pause_signal_from_fw', Int32, queue_size = 1) #21. 04. 06. jmlee -add
                        pause_pub.publish(1)
                        #i_keep = i

                    if cancel:
                        rospy.loginfo("in cancel")
                        repet = repet_count
                        distance = 0.0
                        # 21.01.12 dhjeon add - goals remove
                        waypoints = [] # the waypoint queue
                        cancel = False # 21.03.16 sykim add to cancel test
                    else:
                        distance = math.sqrt(pow(waypoint.pose.pose.position.x-robot_pose[0],2)+pow(waypoint.pose.pose.position.y-robot_pose[1],2)) #mskim add
                    if check_fail_plan:
                        distance_data = distance
                        rospy.loginfo("******************distance_pub = %f", distance_data)
                        #distance_pub.publish(distance_data)
                        if distance_data < 3.0:
                            rospy.loginfo("&&&&&&&&&&&&&&&&&&in distance = %f", distance_data)
                            check_fail_plan = False
                            break
                        else:
                            check_fail_plan = False
                    
                cancel = False
        return 'success'

def convert_PoseWithCovArray_to_PoseArray(waypoints):
    """Used to publish waypoints as pose array so that you can see them in rviz, etc."""
    poses = PoseArray()
    poses.header.frame_id = rospy.get_param('~goal_frame_id','map')
    poses.poses = [pose.pose.pose for pose in waypoints]
    return poses

class GetPath(State):
    def __init__(self):
        State.__init__(self, outcomes=['success'], input_keys=['waypoints'], output_keys=['waypoints'])
        # Create publsher to publish waypoints as pose array so that you can see them in rviz, etc.
        self.poseArray_publisher = rospy.Publisher('/waypoints', PoseArray, queue_size=10)

        # Start thread to listen for reset messages to clear the waypoint queue
        def wait_for_path_reset():
            """thread worker function"""
            global waypoints
            while not rospy.is_shutdown():
                data = rospy.wait_for_message('/path_reset', Empty)
                rospy.loginfo('Recieved path RESET message')
                self.initialize_path_queue()
                rospy.sleep(3) # Wait 3 seconds because `rostopic echo` latches
                               # for three seconds and wait_for_message() in a
                               # loop will see it again.
        reset_thread = threading.Thread(target=wait_for_path_reset)
        reset_thread.start()
        rospy.Subscriber('path_repet', String, PathRepetCallback) #dhjeon-20.12.03-add

    def initialize_path_queue(self):
        global waypoints
        waypoints = [] # the waypoint queue
        # publish empty waypoint queue as pose array so that you can see them the change in rviz, etc.
        self.poseArray_publisher.publish(convert_PoseWithCovArray_to_PoseArray(waypoints))

    def execute(self, userdata):
        global waypoints
        self.initialize_path_queue()
        self.path_ready = False

        # Start thread to listen for when the path is ready (this function will end then)
        # Also will save the clicked path to pose.csv file
        def wait_for_path_ready():
            """thread worker function"""
            data = rospy.wait_for_message('/path_ready', Empty)
            rospy.loginfo('Recieved path READY message')
            self.path_ready = True
            with open(output_file_path, 'w') as file:
                for current_pose in waypoints:
                    file.write(str(current_pose.pose.pose.position.x) + ',' + str(current_pose.pose.pose.position.y) + ',' + str(current_pose.pose.pose.position.z) + ',' + str(current_pose.pose.pose.orientation.x) + ',' + str(current_pose.pose.pose.orientation.y) + ',' + str(current_pose.pose.pose.orientation.z) + ',' + str(current_pose.pose.pose.orientation.w)+ '\n')
                rospy.loginfo('poses written to '+ output_file_path)	
        ready_thread = threading.Thread(target=wait_for_path_ready)
        ready_thread.start()

        self.start_journey_bool = False

        # Start thread to listen start_jorney 
        # for loading the saved poses from follow_waypoints/saved_path/poses.csv
        def wait_for_start_journey():
            """thread worker function"""
            data_from_start_journey = rospy.wait_for_message('start_journey', Empty)
            rospy.loginfo('Recieved path READY start_journey')
            with open(output_file_path, 'r') as file:
                reader = csv.reader(file, delimiter = ',')
                for row in reader:
                    print row
                    current_pose = PoseWithCovarianceStamped() 
                    current_pose.pose.pose.position.x = float(row[0])
                    current_pose.pose.pose.position.y = float(row[1])
                    current_pose.pose.pose.position.z = float(row[2])
                    current_pose.pose.pose.orientation.x = float(row[3])
                    current_pose.pose.pose.orientation.y = float(row[4])
                    current_pose.pose.pose.orientation.z = float(row[5])
                    current_pose.pose.pose.orientation.w = float(row[6])
                    waypoints.append(current_pose)
                    self.poseArray_publisher.publish(convert_PoseWithCovArray_to_PoseArray(waypoints))
            self.start_journey_bool = True
            
            
        start_journey_thread = threading.Thread(target=wait_for_start_journey)
        start_journey_thread.start()

        # 21.02.05 sykim block        
        topic = "/initialpose"
        #rospy.loginfo("Waiting to recieve waypoints via Pose msg on topic %s" % topic)
        #rospy.loginfo("To start following waypoints: 'rostopic pub /path_ready std_msgs/Empty -1'")
        #rospy.loginfo("OR")
        #rospy.loginfo("To start following saved waypoints: 'rostopic pub /start_journey std_msgs/Empty -1'")  
        #srospy.loginfo("subscrib topic!!\n")
        if is_repet:#20.12.03 dhjeon -add  
          os.system('rostopic pub /start_journey std_msgs/Empty -1')

        # Wait for published waypoints or saved path  loaded
        while (not self.path_ready and not self.start_journey_bool):
            try:
                pose = rospy.wait_for_message(topic, PoseWithCovarianceStamped, timeout=1)
            except rospy.ROSException as e:
                if 'timeout exceeded' in e.message:
                    continue  # no new waypoint within timeout, looping...
                else:
                    raise e
            rospy.loginfo("Recieved new waypoint")
            #waypoints.append(pose) # 21.04.02 sykim block - add initpose
            # publish waypoint queue as pose array so that you can see them in rviz, etc.
            self.poseArray_publisher.publish(convert_PoseWithCovArray_to_PoseArray(waypoints))
            
        # Path is ready! return success and move on to the next state (FOLLOW_PATH)
        return 'success'

class PathComplete(State):
    
    def __init__(self):
        State.__init__(self, outcomes=['success'])

    def execute(self, userdata): #20.12.03 dhjeon -changed
        global repet
        global repet_count
        global repet_term
        global is_repet
        global cancel
        global check_pause_state    
        finish_pub = rospy.Publisher('drive_finish_noti', Empty, queue_size = 1)
        rospy.sleep(1)    
        rospy.loginfo('repet before path!! : %d' % repet)
        #rospy.loginfo('term before path!! : %d' % (repet_term*60))
        if repet < repet_count:
            repet = repet + 1
            os.system('rosservice call /move_base/clear_costmaps "{}" &')
            os.system('rosservice call /request_nomotion_update "{}" &')
            is_repet = True
            #rospy.loginfo('term after path!! : %d' % repet_term)
            #rospy.sleep(float(repet_term*60))
            target_time = time.time() + float(repet_term*60)
            while target_time > time.time():
                rospy.loginfo('%f /// %f',target_time, time.time())        
                if cancel:
                    rospy.loginfo('cancel in waitting')
                    break
                cancel = False
            rospy.loginfo('repet after path!! : %d\n' % repet)
        else:
            repet = 1
            repet_count = 1
            is_repet = False
            if check_pause_state != 1 :
                #finish_pub = rospy.Publisher('drive_finish_noti', Empty, queue_size = 1)
                finish_pub.publish(Empty())
                rospy.loginfo(' finish_pub.publish(Empty())')
            os.system('rosservice call /move_base/clear_costmaps "{}" &')
            os.system('rosservice call /request_nomotion_update "{}" &')
            #rospy.loginfo('###############################')
            rospy.loginfo('##### REACHED FINISH GATE #####')
            #rospy.loginfo('###############################')
            #path_run_cancel_request_pub = rospy.Publisher('path_run_cancel_request', Empty, queue_size = 1)
            #path_run_cancel_request_pub.publish(Empty())
        return 'success'

def main():
    rospy.init_node('follow_waypoints')
    sm = StateMachine(outcomes=['success'])
    
    with sm:
        StateMachine.add('GET_PATH', GetPath(), transitions={'success':'FOLLOW_PATH'}, remapping={'waypoints':'waypoints'})
        StateMachine.add('FOLLOW_PATH', FollowPath(), transitions={'success':'PATH_COMPLETE'}, remapping={'waypoints':'waypoints'})
        StateMachine.add('PATH_COMPLETE', PathComplete(), transitions={'success':'GET_PATH'})

    outcome = sm.execute()
