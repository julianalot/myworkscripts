#!/usr/bin/python2.7

import hashlib

filename = input("Enter the file name: ")

hash1 = hashlib.md5(filename).hexdigest()

print(hash1)
