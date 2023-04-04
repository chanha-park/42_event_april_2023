import requests
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


rsp = requests.get("https://pokeapi.co/api/v2/pokemon/" + name)

if rsp.status_code == requests.codes.ok :
    print("Name: " + name)
    print("Abilities:")
    for ent in rsp.json().get("abilities") :
        print("- " + ent.get("ability").get("name"))
else :
    print("no such pokemon")
