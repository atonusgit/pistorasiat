#!/usr/bin/python3

import os
import sys
import json
from dotenv import load_dotenv

load_dotenv()

status_file = os.getenv('ROOT_DIRECTORY') + "/status_files/all_status.json"
sensorit_address = os.getenv('SENSORIT_ADDRESS')
sensorit_root = os.getenv('SENSORIT_ROOT_DIRECTORY')
sensorit_user = os.getenv('SENSORIT_USERNAME')

def write_json(data, status_file='data.json'):
	with open(status_file, 'w', encoding='utf-8') as f:
		json.dump(data, f, indent=4, ensure_ascii=False)

def switch(channel):
	os.system("sudo piHomeEasy 4 " + channel + " 1 " + sys.argv[2])

def update_status_file():
	with open(status_file, encoding='utf-8') as json_file:
		data = json.load(json_file)
		data[sys.argv[1]]["status"] = 'is_read_' + sys.argv[2]

	if sys.argv[1] == "GROUP_A":
		data["B"]["status"] = 'is_read_' + sys.argv[2]
		data["C"]["status"] = 'is_read_' + sys.argv[2]
		data["D"]["status"] = 'is_read_' + sys.argv[2]
		data["E"]["status"] = 'is_read_' + sys.argv[2]

	if sys.argv[1] == "GROUP_B":
		data["G"]["status"] = 'is_read_' + sys.argv[2]
		data["H"]["status"] = 'is_read_' + sys.argv[2]

	write_json(data, status_file)

def interpret_group_status():
        with open(status_file, encoding='utf-8') as json_file:
                data = json.load(json_file)
                if data["B"]["status"] == "is_read_off" and data["C"]["status"] == "is_read_off" and data["D"]["status"] == "is_read_off" and data["E"]["status"] == "is_read_off":
                        data["GROUP_A"]["status"] = "is_read_off"
                else:
                        data["GROUP_A"]["status"] = "mixed"

                if data["B"]["status"] == "is_read_on" and data["C"]["status"] == "is_read_on" and data["D"]["status"] == "is_read_on" and data["E"]["status"] == "is_read_on":
                        data["GROUP_A"]["status"] = "is_read_on"

                if data["G"]["status"] == "is_read_off" and data["H"]["status"] == "is_read_off":
                        data["GROUP_B"]["status"] = "is_read_off"
                else:
                        data["GROUP_B"]["status"] = "mixed"

                if data["G"]["status"] == "is_read_on" and data["H"]["status"] == "is_read_on":
                        data["GROUP_B"]["status"] = "is_read_on"

        write_json(data, status_file)

def remote_control(i):
	channels = {
		"A" : "31415",
		"B" : "42526",
		"C" : "53637",
		"D" : "54637",
		"E" : "55637",
		"F" : "55637", # not in use
		"G" : "56637",
		"H" : "57637",
		"GROUP_A": "58001",
		"GROUP_B": "58002",
	}
	switch(channels.get(i))
	update_status_file()
	interpret_group_status()
	os.system("rsync " + status_file + " " + sensorit_user + "@" + str(sensorit_address) + ":" + sensorit_root + "/status_files/")

remote_control(sys.argv[1])
