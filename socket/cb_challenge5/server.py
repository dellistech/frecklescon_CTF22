import socket
from _thread import *
import hashlib

host = '0.0.0.0'
port = 80

def client_handler(connection):
    while True:
        connection.send(str.encode("ENTER PASSWORD: "))
        data = connection.recv(256)
        input_message = data.decode('utf-8').strip("\n")

        connection.send(str.encode("ENTER 6 DIGIT PIN: "))
        data = connection.recv(7)
        pin = data.decode('utf-8').strip("\n")

        input_message = pin + input_message
        hashed_password_object = hashlib.sha256(input_message.encode())
        hashed_password = hashed_password_object.hexdigest()
        if hashed_password == 'af1b0f77212bef183f75f47378c99a8817028381ba88109e0311b8c0d6f92e33':
            message = "Yay! here's your flag:\nfrecklesCon22{s4lty_p455w0rd5}\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
            break
        else:
            message = f"NO TREATS FOR YOU! TRY AGAIN.\n"
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