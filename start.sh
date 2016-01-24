#!/bin/bash
# set -x			# activate debugging from here
whoami
#screen -dms Test bash -c "ping -c 100 www.google.de"
screen -dmS $1 bash -c "cd /home/vpn/openvpn && openvpn --config /home/vpn/openvpn/config/$1.ovpn" 
#cd /home/vpn/openvpn && openvpn --config ./config/$1.ovpn