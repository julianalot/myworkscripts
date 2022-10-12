#!/usr/bin/python2.7

import hashlib

hash1 = input(Enter 1st Hash: ")
nonce = input("Enter the nonce: ")
nonceCount = input("Enter the Nonce Count: ")
clientNonce = input("Enter the Client-Nonce: ")
QOP = input("Enter the QOP: ")
hash2 = input("Enter 2nd Hash")

answer = hashlib.md5('hash1'+':'+'nonce'+':'+'nonceCount'+':'+'clientNonce'+':'+'QOP'+':'+'hash2').hexdigest()

print(answer)
