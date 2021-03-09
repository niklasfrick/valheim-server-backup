#!/bin/bash

discordwebhook="https://discord.com/api/webhooks/XXXXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXX_XXXXXXXXXXXXXXXXXXXXXX"
worldname="ENTERWORLDNAMEHERE"
now=$(date +"%d-%m-%Y")


# Sending Stopping notifications

/usr/local/bin/discord.sh --webhook-url="${discordwebhook}" --text "@everyone ATTENTION: Valheim server will stop in 10 minutes for backup. Please log out!"

sleep 5m

/usr/local/bin/discord.sh --webhook-url="${discordwebhook}" --text "@everyone ATTENTION: Valheim server will stop in 5 minutes for backup. Please log out!"

sleep 4m

/usr/local/bin/discord.sh --webhook-url="${discordwebhook}" --text "@everyone ATTENTION: Valheim server stops in 1 minute for backup. Log out NOW!"

sleep 1m

/usr/local/bin/discord.sh --webhook-url="${discordwebhook}" --text "Valheim Server stops now!"

# Stop the Service
systemctl stop valheimserver.service

# Create the Backup
# create the new folder
mkdir /home/steam/backups/${now}

# copy the files
cp /home/steam/.config/unity3d/IronGate/Valheim/worlds/${worldname}.db /home/steam/backups/${now}/${worldname}.db

cp /home/steam/.config/unity3d/IronGate/Valheim/worlds/${worldname}.fwl /home/steam/backups/${now}/${worldname}.fwl

# clear backups older than 30 days
/usr/local/bin/vhclearbackups.sh

# Start the Service
systemctl start valheimserver.service

sleep 30s

# check if service is running and post to discord
systemctl is-active --quiet valheimserver.service >/dev/null 2>&1 && /root/scripts/discord.sh --webhook-url="${discordwebhook}" --text "Valheim Server back ONLINE! Happy gaming!" || /usr/local/bin/discord.sh --webhook-url="${discordwebhook}" --text "Valheim Server not started. Please check..."
