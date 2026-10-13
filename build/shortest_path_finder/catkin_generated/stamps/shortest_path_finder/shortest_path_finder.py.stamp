#!/usr/bin/env python3
import rospy
import heapq
import sys
import csv
import math
from geometry_msgs.msg import PoseWithCovarianceStamped
from std_msgs.msg import Empty, String, Int32

# {'A': 0, 'B': 7, 'C': 3, 'D': 9, 'E': 5}

currentPose_ = (0.0,0.0)
waypoints = {}
calculatedGraph = {}

pathRunRequestPub = rospy.Publisher('/path_run_request', String, queue_size = 1)

def getDistance(x1, y1, x2, y2):
        return math.sqrt(math.pow(x2-x1, 2) + math.pow(y2-y1, 2))

def dist(P, A, B):
    
    for i in range(100):
        if (P[0] - A[0]) ** 2 + (P[1] - A[1]) ** 2 > (P[0] - B[0]) ** 2 + (P[1] - B[1]) ** 2:
            A[0] = (A[0] + B[0]) / 2.0
            A[1] = (A[1] + B[1]) / 2.0
            #A = (A + B) / 2
        else:
            B[0] = (A[0] + B[0]) / 2.0
            B[1] = (A[1] + B[1]) / 2.0
            #B = (A + B) / 2
    dist = ( (P[0] - A[0]) ** 2 + (P[1] - A[1]) ** 2 ) ** 0.5
    return ( dist )

def connectTwoPoints(index1, index2):
    if index1 in waypoints and index2 in waypoints :
        value1 = waypoints[index1]
        value2 = waypoints[index2]
        distance = getDistance(value1[0],value1[1],value2[0],value2[1])
        graphValue = calculatedGraph.get( index1,{})
        graphValue.update( { index2: distance} )
        calculatedGraph.update( {index1:graphValue} )
        graphValue = calculatedGraph.get( index2,{})
        graphValue.update( { index1: distance} )
        calculatedGraph.update( {index2:graphValue} )
    else :
        return 0
        

def dijkstra(start):
    
    distances = {node: sys.maxsize for node in calculatedGraph}
    paths = {node: [start] for node in calculatedGraph}
    
    # distances[start] = 0
    distances[start] = getDistance( waypoints[start][0], waypoints[start][1], currentPose_[0], currentPose_[1] )
    queue = []
    
    heapq.heappush(queue, (distances[start], start))
        
    while queue:

        #print(queue)
        #print('paths', paths)

        current_distance, node = heapq.heappop(queue)
        
        if distances[node] < current_distance:
            
            continue
        
        for adjacency_node, distance in calculatedGraph[node].items():

            weighted_distance = current_distance + distance

            if weighted_distance < distances[adjacency_node]:
                
                distances[adjacency_node] = weighted_distance
                tempList = paths[node].copy()                
                tempList.append(adjacency_node)
                paths[adjacency_node] = tempList
                # paths[adjacency_node] = paths[node].append(adjacency_node)
                
                heapq.heappush(queue, (weighted_distance, adjacency_node))

            else :
                if not paths[adjacency_node][len(paths[adjacency_node])-1] == adjacency_node :
                    paths[adjacency_node].append(adjacency_node)               

    return distances, paths


def amclPoseCallback(data):
    global currentPose_
    currentPose_ = [data.pose.pose.position.x, data.pose.pose.position.y]
    # print(currentPose)
    return


def requestShortestGuideCallback(data):

    print (data.data)

    global currentPose_

    nearestDistance = sys.maxsize
    nearestIndex1 = 0
    nearestIndex2 = 0

    for key in calculatedGraph:
        # print('nearestIndex1 : %d , nearestIndex2 : %d' %(nearestIndex1,nearestIndex2) )
        secondGraph = calculatedGraph[key]
        for key2 in secondGraph:
            point1 = [ waypoints[key][0], waypoints[key][1] ]
            point2 = [ waypoints[key2][0], waypoints[key2][1] ]
            distance = dist(currentPose_, point1, point2)
            # print( currentPose, point1, point2)
            # print ('distance : %f' %distance)
            if distance < nearestDistance :
                nearestDistance = distance
                nearestIndex1 = key
                nearestIndex2 = key2
    
    result1 = dijkstra(nearestIndex1)
    result2 = dijkstra(nearestIndex2)

    print('================= result1 ===================')
    print(result1)
    print('================= result2 ===================')
    print(result2)

    goalIndex = data.data

    print('goalIndex : %d' %goalIndex)

    if goalIndex > -1 :
        result = []
        if result1[0][goalIndex] < result2[0][goalIndex] :
            result = result1[1][goalIndex]
        else :
            result = result2[1][goalIndex]

        f = open('/home/nvidia/dconic_nav/src/follow_waypoints/saved_path/to_guide_point.csv','w', newline='')
        wr = csv.writer(f)
        # wr.writerow([1,'림코딩', '부산'])
        # wr.writerow([2,'김갑환', '서울'])
        for index in result :
            wr.writerow(waypoints[index])        
        f.close()
        
        stringMsg = String('0100to_guide_point.csv')
        pathRunRequestPub.publish(stringMsg)


def main():
    rospy.init_node('shortest_path_finder')

    rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, amclPoseCallback)
    rospy.Subscriber('/request_shortest_guide', Int32, requestShortestGuideCallback)
    
    lineCount = 0
    f = open('/home/nvidia/dconic_nav/src/follow_waypoints/saved_path/parc1_shortest_path.csv','r')
    rdr = csv.reader(f)
    for line in rdr:
        waypoints.update( {lineCount : ( float(line[0]), float(line[1]), float(line[2]), float(line[3]), float(line[4]), float(line[5]), float(line[6]) ) } )
        lineCount=lineCount+1
    f.close() 

    connectTwoPoints(0, 1)
    connectTwoPoints(1, 0)

    connectTwoPoints(1, 2)
    connectTwoPoints(2, 1)

    connectTwoPoints(2, 3)
    connectTwoPoints(3, 2)    

    # print(waypoints)

    # for value in waypoints:
    #     print(value[0])

    print('----------calculatedGraph-----------')
    print(calculatedGraph) 

    # print('dist example : ')
    # print(dist([0.0,1.0],[1.0,0.0],[3.0,0.0]))           

    

    # # graph = {
    # #     '0': {'1': 10, '2': 3},
    # #     '1': {'2': 1, '3': 2, '0': 5},
    # #     '2': {'1': 4, '3': 8, '4': 2},
    # #     '3': {'4': 7},
    # #     '4': {'3': 9, '0': 7},
    # # }

    # result = dijkstra(0)
    # print('-----------------result-----------------')
    # print(result)

 
 
    rospy.spin()


if __name__ == '__main__':
	main()
