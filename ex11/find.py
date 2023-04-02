#  import requests
#  import pokepy
import traceback
import logging

try:
    name = input("Enter the name of a Pokemon: ")
except EOFError:
    print("EOF Error!, Exit")
    exit()
except Exception as e:
    logging.error(traceback.format_exc())
    exit()

print(name)
