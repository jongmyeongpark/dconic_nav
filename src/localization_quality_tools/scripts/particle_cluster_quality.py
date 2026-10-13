#!/usr/bin/env python
import rospy
import numpy as np
from geometry_msgs.msg import PoseArray
from std_msgs.msg import String, Float32
from sklearn.cluster import DBSCAN

class ParticleClusterQuality:
    def __init__(self):
        rospy.init_node("particle_cluster_quality") 

        # Params
        self.eps = rospy.get_param("~eps", 0.25)           # DBSCAN 반경
        self.min_pts = rospy.get_param("~min_pts", 8)      # 최소 포인트 개수
        self.max_clusters_ok = rospy.get_param("~max_clusters_ok", 1)  
        self.min_main_ratio_ok = rospy.get_param("~min_main_ratio_ok", 0.65)  
        self.max_std_ok = rospy.get_param("~max_std_ok", 0.20)  # m
        self.max_particles = rospy.get_param("~max_particles", 500)  # 다운샘플링 최대 수

        # Publishers
        self.status_pub = rospy.Publisher("~status", String, queue_size=10)
        self.score_pub = rospy.Publisher("~main_cluster_ratio", Float32, queue_size=10)

        # Latest particlecloud 저장
        self.latest_pts = None
        rospy.Subscriber("/particlecloud", PoseArray, self.cb_particlecloud)

        # 3초마다 평가 실행
        rospy.Timer(rospy.Duration(3.0), self.evaluate)

        rospy.loginfo("[particle_cluster_quality] eps=%.2f, min_pts=%d, max_particles=%d",
                      self.eps, self.min_pts, self.max_particles)

        rospy.spin()

    def cb_particlecloud(self, msg):
        """ /particlecloud 콜백 → 좌표 저장 """
        if not msg.poses:
            return
        pts = np.array([[p.position.x, p.position.y] for p in msg.poses], dtype=float)
        if pts.shape[0] < max(self.min_pts, 5):
            rospy.logwarn("Too few particles: %d", pts.shape[0])
            return
        self.latest_pts = pts

    def evaluate(self, event):
        """ 주기적으로 파티클 클러스터 품질 평가 """
        if self.latest_pts is None:
            return

        pts = self.latest_pts

        # 다운샘플링
        if pts.shape[0] > self.max_particles:
            idx = np.random.choice(pts.shape[0], self.max_particles, replace=False)
            pts = pts[idx]

        # DBSCAN with kd-tree
        db = DBSCAN(eps=self.eps, min_samples=self.min_pts, algorithm="kd_tree").fit(pts)
        labels = db.labels_

        # cluster stats
        valid = labels >= 0
        if not valid.any():
            status = "BAD: all noise"
            self.status_pub.publish(status)
            rospy.logwarn(status)
            return

        clusters, counts = np.unique(labels[valid], return_counts=True)
        num_clusters = clusters.size
        main_size = counts.max()
        total = float(pts.shape[0])
        main_ratio = main_size / total

        # intra-cluster std of the largest cluster
        main_label = clusters[np.argmax(counts)]
        main_pts = pts[labels == main_label]
        std_xy = np.std(main_pts, axis=0)  # [std_x, std_y]
        std_mean = float(np.mean(std_xy))

        # Rule-based classification
        if num_clusters <= self.max_clusters_ok and main_ratio >= self.min_main_ratio_ok and std_mean <= self.max_std_ok:
            status = "GOOD"
        elif num_clusters <= 2 and main_ratio >= 0.5 and std_mean <= (self.max_std_ok * 1.5):
            status = "UNCERTAIN"
        else:
            status = "BAD"

        rospy.loginfo("Clusters=%d, main_ratio=%.2f, std=%.3f -> %s",
                      num_clusters, main_ratio, std_mean, status)
        self.status_pub.publish(status)
        self.score_pub.publish(main_ratio)

if __name__ == "__main__":
    ParticleClusterQuality()