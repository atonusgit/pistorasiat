#!/bin/bash

# Wait before checking (useful if just booted or network is slow)
sleep 60

# Ping Google's DNS to test internet connection
if ! ping -c 1 -W 3 8.8.8.8 >/dev/null 2>&1; then
    #echo "$(date): No internet. Rebooting..." >> /home/pi/internet_monitor.log
    #sudo /sbin/shutdown -r now
    echo "$(date): No internet. Rebooting wifi..." >> /home/pi/internet_monitor.log
    sudo ip link set wlan0 down
    sleep 5
    sudo ip link set wlan0 up
fi
