# Socket Challenges

These Challenges require you to connect to a remote IP address over port 80 and attempt to crack the password to get into Freckles' Treat Vault!

## Challenge 1: Cats on the Network
```IP: 1.2.3.4```
### Solution: frecklesCon22{c4t5_0n_th3_n3t}
Can you connect to Freckles Vault and give the secret phrase?

## Challenge 2: Put a PIN on it
```IP: 1.2.3.4```
### Solution: frecklesCon22{tr34t5_4cqu1r3d}
Freckles wanted to protect his treats, so he put a 3 digit PIN on his vault! Can you crack it? (HINT: PIN is in range 100 - 999)

## Challenge 3: Put a BIGGER PIN on it
```IP: 1.2.3.4```
### Solution: frecklesCon22{m04r_tr34t5_4cqu1r3d}
Freckles didn't want to give up his treats so easily, so he changed up the PIN! Now the connection doesn't reset after every attempt, and the PIN is now 6 digits! (HINT: Range is between 100000 - 999999)

## Challenge 4: You Can't Spell PASSWORD without PAWS
```IP: 1.2.3.4```
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
```IP: 1.2.3.4```
### Solution: frecklesCon22{s4lty_p455w0rd5}
Freckles decided to go all out for his security, but (again) because he's a dog, he accidentally uploaded some of his code to github! Classic Freckles! Thankfully we were able to capture some key data:

We know his password is: ```freckles_loves_treats```

And we also know that his treat vault uses Python to check the password like this:
```
def client_handler(connection):
    connection.send(str.encode("ENTER PASSWORD: "))
    while True:
        data = connection.recv(256)
        input_message = data.decode('utf-8').strip("\n")
        pin = <SIX DIGIT PIN>
        input_message = pin + '_' + input_message
        hashed_password_object = hashlib.sha256(input_message.encode())
        hashed_password = hashed_password_object.hexdigest()
        if hashed_password == 'b79380397289a3965c0733847e881b39e176e035f1c8c40b9fb71a3187be2093':
            message = "Yay! here's your flag:\n<FLAG GOES HERE>\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
            break
        else:
            message = f"NO TREATS FOR YOU! TRY AGAIN.\n"
            reply = f'Server: {message}'
            connection.sendall(str.encode(reply))
    connection.close()
```


