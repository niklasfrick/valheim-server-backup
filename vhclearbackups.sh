#!/bin/bash

# finds all folders that are older than 30 days (ctime)change to whatever days you like, and deletes them.

find /home/steam/backups/* -type d -ctime +30 -exec rm -rf {} \;
