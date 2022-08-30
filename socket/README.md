# Socket Challenges

These Challenges require you to connect to a remote IP address over port 80 and attempt to crack the password to get into Freckles' Treat Vault!

## Challenge 1: Cats on the Network
```IP: 192.241.129.112 Port: 80```
### Solution: frecklesCon22{c4t5_0n_th3_n3t}
Can you connect to Freckles Vault and give the secret phrase?

## Challenge 2: Put a PIN on it
```IP: 147.182.190.157 Port: 80```
### Solution: frecklesCon22{tr34t5_4cqu1r3d}
Freckles wanted to protect his treats, so he put a 3 digit PIN on his vault! Can you crack it? (HINT: PIN is in range 100 - 999)

## Challenge 3: Put a BIGGER PIN on it
```IP: 137.184.111.16 Port: 80```
### Solution: frecklesCon22{m04r_tr34t5_4cqu1r3d}
Freckles didn't want to give up his treats so easily, so he changed up the PIN! Now the connection doesn't reset after every attempt, and the PIN is now 6 digits! (HINT: Range is between 100000 - 999999)

## Challenge 4: You Can't Spell PASSWORD without PAWS
```IP: 198.211.116.79 Port: 80```
### Solution: frecklesCon22{d1ct10n4ry_4774ck5}
Freckles wanted to set up a stronger mechanism for his vault, so he made a 3 word password. Because his arms are so short, he couldn't reach the space bar between words. So his password is a single string that looks something like:

```word1word2word3```

And because he's such a busy dog, we also know he likes to keep his passwords memorable, so we know he's using some combination of these words:
```
ctf
pcyber
brian
cervando
hacking
treats
freckles
con
```

## Challenge 5: So Salty
```IP: 165.227.86.88 Port: 80```
### Solution: frecklesCon22{s4lty_p455w0rd5}
Freckles decided to go all out for his security, but (again) because he's a dog, he accidentally uploaded some of his code to github! Classic Freckles! Thankfully we were able to capture some key data! We know he is using a password as well as a 6 digit pin and uses Python to check the password like this:
```
def client_handler(connection):
    while True:
        connection.send(str.encode("ENTER PASSWORD: "))
        data = connection.recv(256)
        input_message = data.decode('utf-8').strip("\n")

        connection.send(str.encode("ENTER 6 DIGIT PIN: "))
        data = connection.recv(6)
        pin = data.decode('utf-8').strip("\n")

        input_message = pin + input_message
        hashed_password_object = hashlib.sha256(input_message.encode())
        hashed_password = hashed_password_object.hexdigest()
        if hashed_password == 'af1b0f77212bef183f75f47378c99a8817028381ba88109e0311b8c0d6f92e33':
            message = "Yay! here's your flag:\nfrecklesCon22{<ERROR DATA CORRUPTED>}\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
            break
        else:
            message = f"NO TREATS FOR YOU! TRY AGAIN.\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
    connection.close()
```

We again were able to narrow down the password to a 3 word combination ```word1word2word3``` from the list:
```
ctf
pcyber
brian
cervando
hacking
treats
freckles
con
```

Can you get his treats?
