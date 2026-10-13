#!/usr/bin/env python3.8

import rospy
import serial
import threading
from std_msgs.msg import String, Empty, Int32
# from dobot_bringup.srv import PauseScript, ContinueScript, pause, Continues
environmentDataPublisher = rospy.Publisher("environment_data", String, queue_size=1)

class ENVConnection(threading.Thread) :
    
    def __init__(self, serial_port, baud_rate=115200):
        """
        Initializes the serial connection and starts the thread to read
        data from the serial port.
        """
        super().__init__()
        self.port = serial_port
        self.baud_rate = baud_rate
        self.is_running = False

        # Initialize serial connection
        self.ser = serial.Serial(serial_port, baud_rate, timeout=1)

    def read_serial(self):
        """
        Read data from serial port and print it to the terminal.
        """
        self.is_running = True

        try:
            while self.is_running:
            # Read a line from the serial port
                raw_line = self.ser.readline()
                try:
                    line = raw_line.decode('utf-8').strip()
                    if len(line) > 0:
                        self.on_read(line)
                    else:
                        rospy.loginfo('No receive msg')
                except UnicodeDecodeError as error:
                    print(f"UnicodeDecodeError : ({error})")

        except serial.SerialException as error:
            print(f"SerialException : ({error})")

    def on_read(self, data : str):
        """
        Called when data is read from the serial port.
        """
        # pass
        print(data)
        
        acc = int(data[8])
        iaq = int(data[9:12])
        pressure = int(data[12:16])
        co2 =  int(data[16:20])
        breath =  int(data[20:24])
        temp =  int(data[24:28])
        hum =  int(data[28:32])
        gas =  int(data[32:36])
        print(f'acc: {acc}, iaq: {iaq}, pressure: {pressure}, co2: {co2}, breath: {breath}, temp: {temp/10}, humidity: {hum/10}, gas: {gas/10}')
        environmentDataPublisher.publish(String(data[8:36]))

    def run(self):
        self.read_serial()
        
    def release(self):
        """
        Close the serial port.
        """
        self.is_running = False
        self.ser.close()


if __name__ == "__main__":
    rospy.init_node("env_serials")

    env_serials = rospy.get_param("~env_serials_device", "/dev/ttyEnv")
    rospy.loginfo(f"env_serials_device : {env_serials}")
    

    env_serials_conn = ENVConnection(env_serials)

    def shutdown():
        env_serials_conn.release()

    rospy.on_shutdown(shutdown)

    env_serials_conn.start()
    rospy.spin()