import serial
import rospy
import rospy

from sensor_msgs.msg import Imu
from std_msgs.msg import Float32
from std_msgs.msg import String
from std_msgs.msg import Bool
from sensor_msgs.msg import Range

port = '/dev/ttyMycomDebugger'
baud_rate = 115200

ser = serial.Serial(port, baud_rate, timeout=0.1)

pubir1 = rospy.Publisher("irdata1_topic", Range, queue_size=1)
pubir2 = rospy.Publisher("irdata2_topic", Range, queue_size=1)
pubir3 = rospy.Publisher("irdata3_topic", Range, queue_size=1)
pubir4 = rospy.Publisher("irdata4_topic", Range, queue_size=1)
pubir5 = rospy.Publisher("irdata5_topic", Range, queue_size=1)
pubir6 = rospy.Publisher("irdata6_topic", Range, queue_size=1)
pubir7 = rospy.Publisher("irdata7_topic", Range, queue_size=1)
pubir8 = rospy.Publisher("irdata8_topic", Range, queue_size=1)
pubsonar1 = rospy.Publisher("sonardata1_topic", Range, queue_size=1)
pubsonar2 = rospy.Publisher("sonardata2_topic", Range, queue_size=1)
pubsonar3 = rospy.Publisher("sonardata3_topic", Range, queue_size=1)
pubsonar4 = rospy.Publisher("sonardata4_topic", Range, queue_size=1)
pubsonar5 = rospy.Publisher("sonardata5_topic", Range, queue_size=1)
pubsonar6 = rospy.Publisher("sonardata6_topic", Range, queue_size=1)
pubsonar7 = rospy.Publisher("sonardata7_topic", Range, queue_size=1)
pubsonar8 = rospy.Publisher("sonardata8_topic", Range, queue_size=1)
pubble = rospy.Publisher("bledata", String, queue_size=1)
pubblelong = rospy.Publisher("bledata_long", String, queue_size=1)

def ble_data(data):
    pubble.publish(data)

def blelong_data(data):
    pubblelong.publish(data)

def ir_data(data):    
    msg1 = Range()
    msg1.header.stamp = rospy.Time.now() 
    msg1.header.frame_id = "ir1_frame" 
    msg1.radiation_type = Range.INFRARED
    msg1.field_of_view = 0.5
    msg1.min_range = 0.2
    msg1.max_range = 0.94
    msg1.range = data[8:11]
    
    msg2 = Range()
    msg2.header.stamp = rospy.Time.now() 
    msg2.header.frame_id = "ir2_frame" 
    msg2.radiation_type = Range.INFRARED
    msg2.field_of_view = 0.5
    msg2.min_range = 0.2
    msg2.max_range = 0.94
    msg2.range = data[11:14]
    
    msg3 = Range()
    msg3.header.stamp = rospy.Time.now() 
    msg3.header.frame_id = "ir3_frame" 
    msg3.radiation_type = Range.INFRARED
    msg3.field_of_view = 0.5
    msg3.min_range = 0.2
    msg3.max_range = 0.94
    msg3.range = data[14:17]
    
    msg4 = Range()
    msg4.header.stamp = rospy.Time.now() 
    msg4.header.frame_id = "ir4_frame" 
    msg4.radiation_type = Range.INFRARED
    msg4.field_of_view = 0.5
    msg4.min_range = 0.2
    msg4.max_range = 0.94
    msg4.range = data[17:20]
    
    msg5 = Range()
    msg5.header.stamp = rospy.Time.now() 
    msg5.header.frame_id = "ir5_frame" 
    msg5.radiation_type = Range.INFRARED
    msg5.field_of_view = 0.5
    msg5.min_range = 0.2
    msg5.max_range = 0.94
    msg5.range = data[20:23]

    msg6 = Range()
    msg6.header.stamp = rospy.Time.now() 
    msg6.header.frame_id = "ir6_frame" 
    msg6.radiation_type = Range.INFRARED
    msg6.field_of_view = 0.5
    msg6.min_range = 0.2
    msg6.max_range = 0.94
    msg6.range = data[23:26]
    
    msg7 = Range()
    msg7.header.stamp = rospy.Time.now() 
    msg7.header.frame_id = "ir7_frame" 
    msg7.radiation_type = Range.INFRARED
    msg7.field_of_view = 0.5
    msg7.min_range = 0.2
    msg7.max_range = 0.94
    msg7.range = data[26:29]
    
    msg8 = Range()
    msg8.header.stamp = rospy.Time.now() 
    msg8.header.frame_id = "ir8_frame" 
    msg8.radiation_type = Range.INFRARED
    msg8.field_of_view = 0.5
    msg8.min_range = 0.2
    msg8.max_range = 0.94
    msg8.range = data[29:32]

    pubir1.publish(msg1)
    pubir2.publish(msg2)
    pubir3.publish(msg3)
    pubir4.publish(msg4)
    pubir5.publish(msg5)
    pubir6.publish(msg6)
    pubir7.publish(msg7)
    pubir8.publish(msg8)

def sonar_data8(data):
    msg1 = Range()
    msg1.header.stamp = rospy.Time.now() 
    msg1.header.frame_id = "sonar1_frame" 
    msg1.radiation_type = Range.ULTRASOUND
    msg1.field_of_view = 0.87
    msg1.min_range = 0.2 
    msg1.max_range = 4.5
    msg1.range = data[8:11]
    
    msg2 = Range()
    msg2.header.stamp = rospy.Time.now() 
    msg2.header.frame_id = "sonar2_frame" 
    msg2.radiation_type = Range.ULTRASOUND
    msg2.field_of_view = 0.87
    msg2.min_range = 0.2 
    msg2.max_range = 4.5
    msg2.range = data[11:14]
    
    msg3 = Range()
    msg3.header.stamp = rospy.Time.now() 
    msg3.header.frame_id = "sonar3_frame" 
    msg3.radiation_type = Range.ULTRASOUND
    msg3.field_of_view = 0.87
    msg3.min_range = 0.2 
    msg3.max_range = 4.5
    msg3.range = data[14:17]
    
    msg4 = Range()
    msg4.header.stamp = rospy.Time.now() 
    msg4.header.frame_id = "sonar4_frame" 
    msg4.radiation_type = Range.ULTRASOUND
    msg4.field_of_view = 0.87
    msg4.min_range = 0.2 
    msg4.max_range = 4.5
    msg4.range = data[17:20]
    
    msg5 = Range()
    msg5.header.stamp = rospy.Time.now() 
    msg5.header.frame_id = "sonar5_frame" 
    msg5.radiation_type = Range.ULTRASOUND
    msg5.field_of_view = 0.87
    msg5.min_range = 0.2 
    msg5.max_range = 4.5
    msg5.range = data[20:23]

    msg6 = Range()
    msg6.header.stamp = rospy.Time.now() 
    msg6.header.frame_id = "sonar6_frame" 
    msg6.radiation_type = Range.ULTRASOUND
    msg6.field_of_view = 0.87
    msg6.min_range = 0.2 
    msg6.max_range = 4.5
    msg6.range = data[23:26]
    
    msg7 = Range()
    msg7.header.stamp = rospy.Time.now() 
    msg7.header.frame_id = "sonar7_frame" 
    msg7.radiation_type = Range.ULTRASOUND
    msg7.field_of_view = 0.87
    msg7.min_range = 0.2 
    msg7.max_range = 4.5
    msg7.range = data[26:29]
    
    msg8 = Range()
    msg8.header.stamp = rospy.Time.now() 
    msg8.header.frame_id = "sonar8_frame" 
    msg8.radiation_type = Range.ULTRASOUND
    msg8.field_of_view = 0.87
    msg8.min_range = 0.2 
    msg8.max_range = 4.5
    msg8.range = data[29:32]

    pubsonar1.publish(msg1)
    pubsonar2.publish(msg2)
    pubsonar3.publish(msg3)
    pubsonar4.publish(msg4)
    pubsonar5.publish(msg5)
    pubsonar6.publish(msg6)
    pubsonar7.publish(msg7)
    pubsonar8.publish(msg8)

def sonar_data4(data):
    msg1 = Range()
    msg1.header.stamp = rospy.Time.now() 
    msg1.header.frame_id = "sonar1_frame" 
    msg1.radiation_type = Range.ULTRASOUND
    msg1.field_of_view = 0.87
    msg1.min_range = 0.2 
    msg1.max_range = 4.5
    msg1.range = data[8:11]
    
    msg2 = Range()
    msg2.header.stamp = rospy.Time.now() 
    msg2.header.frame_id = "sonar2_frame" 
    msg2.radiation_type = Range.ULTRASOUND
    msg2.field_of_view = 0.87
    msg2.min_range = 0.2 
    msg2.max_range = 4.5
    msg2.range = data[11:14]
    
    msg3 = Range()
    msg3.header.stamp = rospy.Time.now() 
    msg3.header.frame_id = "sonar3_frame" 
    msg3.radiation_type = Range.ULTRASOUND
    msg3.field_of_view = 0.87
    msg3.min_range = 0.2 
    msg3.max_range = 4.5
    msg3.range = data[14:17]
    
    msg4 = Range()
    msg4.header.stamp = rospy.Time.now() 
    msg4.header.frame_id = "sonar4_frame" 
    msg4.radiation_type = Range.ULTRASOUND
    msg4.field_of_view = 0.87
    msg4.min_range = 0.2 
    msg4.max_range = 4.5
    msg4.range = data[17:20]

    pubsonar1.publish(msg1)
    pubsonar2.publish(msg2)
    pubsonar3.publish(msg3)
    pubsonar4.publish(msg4)

def sonar_data2(data):
    msg1 = Range()
    msg1.header.stamp = rospy.Time.now() 
    msg1.header.frame_id = "sonar1_frame" 
    msg1.radiation_type = Range.ULTRASOUND
    msg1.field_of_view = 0.87
    msg1.min_range = 0.2 
    msg1.max_range = 4.5
    msg1.range = data[8:11]
    
    msg2 = Range()
    msg2.header.stamp = rospy.Time.now() 
    msg2.header.frame_id = "sonar2_frame" 
    msg2.radiation_type = Range.ULTRASOUND
    msg2.field_of_view = 0.87
    msg2.min_range = 0.2 
    msg2.max_range = 4.5
    msg2.range = data[11:14]

    pubsonar1.publish(msg1)
    pubsonar2.publish(msg2)

def main():
    rospy.init_node('esp32_ir_node', anonymous=True)
    
    while True:
        try:
            data = ser.readline().decode('latin-1').strip()

            if len(data) == 6 and data[:2] == '\xaf\xfa':
                ble_data(data)
            elif len(data) == 15 and data[:8] == "{00CC004":
                blelong_data(data)
            elif len(data) == 19 and data[:8] == "{0080024":
                ir_data(data)
            elif len(data) == 35 and data[:8] == "{0090024":
                sonar_data8(data)
            elif len(data) == 23 and data[:8] == "{0090012":
                sonar_data4(data)
            elif len(data) == 17 and data[:8] == "{0090006":
                sonar_data2(data)

        except KeyboardInterrupt:
            ser.close()
            print("Serial port closed")

if __name__ == '__main__':
    main()
