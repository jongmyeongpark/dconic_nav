# from __future__ import print_function
import roslibpy

# 브릿지와 연결
client = roslibpy.Ros(host='localhost', port=9090)
client.run()

# 토픽 생성
listener = roslibpy.Topic(client, '/chatter', 'std_msgs/String')

# lambda 형태로 받은 메시지 출력 
listener.subscribe(lambda message: print('Heard talking: ' + message['data']))

'''
# 위 lambda 형식은 아래와 같이 변경도 가능하다.
def receive(message):
    print('Heard talking: ' + message['data'])

listener.subscribe(receive)
'''

# 키보드 종료(ctrl+c)를 누를때까지 대기
try:
    while True:
        pass
except KeyboardInterrupt:
    client.terminate()