#!/bin/bash
# set -x			# activate debugging from here
ifconfig -a | sed 's/[ \t].*//;/^$/d'
