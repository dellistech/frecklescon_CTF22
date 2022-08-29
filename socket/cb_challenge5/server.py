import socket
from _thread import *
import hashlib

host = '127.0.0.1'
port = 9090

def client_handler(connection):
    connection.send(str.encode("ENTER PASSWORD: "))
    while True:
        data = connection.recv(256)
        input_message = data.decode('utf-8').strip("\n")
        pin = '931459'
        input_message = pin + '_' + input_message
        hashed_password_object = hashlib.sha256(input_message.encode())
        hashed_password = hashed_password_object.hexdigest()
        if hashed_password == 'b79380397289a3965c0733847e881b39e176e035f1c8c40b9fb71a3187be2093':
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