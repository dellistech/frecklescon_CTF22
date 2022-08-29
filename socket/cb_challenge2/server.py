import socket
from _thread import *

host = '127.0.0.1'
port = 9090

def client_handler(connection):
    connection.send(str.encode("ENTER 3 DIGIT PIN FOR FRECKLES TREAT VAULT. \n LEADING ZEROES ARE VALD INPUT (000 - 999):\n"))
    while True:
        data = connection.recv(3)
        input_message = data.decode('utf-8').strip("\n")
        if input_message == 'BYE':
            break
        if input_message == '634':
            message = "Yay! here's your flag:\nfrecklesCon22{tr34t5_4cqu1r3d}\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
            break
        else:
            message = f"{input_message} IS WRONG. NO TREATS FOR YOU! TRY AGAIN.\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
            break
    connection.close()

def accept_connections(ServerSocket):
    Client, address = ServerSocket.accept()
    print('Connected to: ' + address[0] + ':' + str(address[1]))
    start_new_thread(client_handler, (Client, ))

def start_server(host, port):
    ServerSocket = socket.socket()
    try:
        ServerSocket.bind((host, port))
    except socket.error as e:
        print(str(e))
    print(f'Server is listing on the port {port}...')
    ServerSocket.listen()

    while True:
        accept_connections(ServerSocket)
start_server(host, port)

#for ((i=0;i<1000;i++)); do echo $i | nc 127.0.0.1 9090;done | grep frecklesCon