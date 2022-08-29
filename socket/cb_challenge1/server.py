import socket
from _thread import *

host = '127.0.0.1'
port = 9090

def client_handler(connection):
    connection.send(str.encode("Be Friendly. Be Curious. Be Like _______\n"))
    acceptable_answers = ['Freckles', 'freckles', 'FRECKLES']
    while True:
        data = connection.recv(256)
        message = data.decode('utf-8').strip("\n")
        if message == 'BYE':
            break
        if message in acceptable_answers:
            message = "Yay! here's your flag:\nfrecklesCon22{c4t5_0n_th3_n3t}\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
            break
        else:
            message = "hmm not quite. try again\n"
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