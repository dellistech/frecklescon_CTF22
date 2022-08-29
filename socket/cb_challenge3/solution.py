import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('127.0.0.1',9090))

data = s.recv(1024)
print(data.decode('utf-8'))

for pin in range(100000,999999):
	print(f'Sending {pin}')
	s.sendall(str(pin).encode())
	response = s.recv(1024)
	response = response.decode('utf-8')
	if 'frecklesCon' in response:
		print(response)
		break

