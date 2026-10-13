import serial

# Define the port name and baud rate
port = '/dev/ttyMycomDebugger'  # Replace this with your actual port name
baud_rate = 115200

# Create a serial object
ser = serial.Serial(port, baud_rate, timeout=0.1)
# a = 'AF FA 04 00 AF B0'
# ser.write(a.encode('latin-1')) 
# a = '{00CC0040100SS}'
# ser.write(a.encode('latin-1'))
# 시작
a = "{00CC004010035}"
# 정지
# a = "{00CC004040030}"
ser.write(a.encode('ascii'))

# t = [0xAF, 0xFA, 0x01, 0x00, 0xAF, 0xB0]
# t = [0xAF, 0xFA, 0x04, 0x00, 0xAF, 0xB0]
# ser.write(bytearray(t))
