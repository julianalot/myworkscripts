from passlib.hash import sha512_crypt
import getpass,string,random

password = input("Please enter your plaintext password: ")
hashed = (print(sha512_crypt.using(salt=''.join([random.choice(string.ascii_letters + string.digits) for _ in range(16)]),rounds=5000).hash('password')))
print('Your hashed password is: ' + str(hashed))