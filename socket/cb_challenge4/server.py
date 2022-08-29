import socket
from _thread import *

host = '127.0.0.1'
port = 9090

def client_handler(connection):
    connection.send(str.encode("Enter 3 word password, each word separated by underscore _: \n"))
    while True:
        data = connection.recv(256)
        input_message = data.decode('utf-8').strip("\n")
        if input_message == 'BYE':
            break
        if input_message == 'freckles_treats_pcyber':
            message = "Yay! here's your flag:\nfrecklesCon22{d1ct10n4ry_4774ck5}\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
            break
        else:
            message = f"{input_message} IS WRONG. NO TREATS FOR YOU! TRY AGAIN.\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
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