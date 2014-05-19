import socket
import time
import serial


# UDP settings
host = "0.0.0.0"
port = 4000
buffer_size = 150

ringInterface = "/dev/tty.usbmodem12341"

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((host,port))

with serial.Serial(ringInterface, 115200, timeout=0) as ser:

	while True:
		data, addr = sock.recvfrom(buffer_size)
		if ord(data[0]) != 1:
			print "RX Error"
			continue

		ringData = data[1:-1]
		bulbData = data[-1]

		packet1 = ringData[0:51]	# len 51
		packet2 = ringData[51:100]	# len 49
		packet3 = ringData[100:148]	# len 48

		ser.write(packet1)
		ser.write(packet2)
		ser.write(packet3)


