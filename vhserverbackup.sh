#!/bin/bash

discordwebhook="https://discord.com/api/webhooks/XXXXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXX_XXXXXXXXXXXXXXXXXXXXXX"
worldname="ENTERWORLDNAMEHERE"
now=$(date +"%d-%m-%Y")


# Sending Stopping notifications

/usr/local/sbin/discord.sh --webhook-url="${discordwebhook}" --text "@everyone ATTENTION: Valheim server will stop in 10 minutes for backup. Please log out!"

sleep 5m

/usr/local/sbin/discord.sh --webhook-url="${discordwebhook}" --text "@everyone ATTENTION: Valheim server will stop in 5 minutes for backup. Please log out!"

sleep 4m

/usr/local/sbin/discord.sh --webhook-url="${discordwebhook}" --text "@everyone ATTENTION: Valheim server stops in 1 minute for backup. Log out NOW!"

sleep 1m

/usr/local/sbin/discord.sh --webhook-url="${discordwebhook}" --text "Valheim Server stops now!"

# Stop the Service
systemctl stop valheimserver_${worldname}.service

sleep 1m

# Create the Backup

# create the new folder
mkdir /home/steam/backups/${now}

# copy the files
cp /home/steam/.config/unity3d/IronGate/Valheim/${worldname}/worlds/${worldname}.db /home/steam/backups/${now}/${worldname}.db

cp /home/steam/.config/unity3d/IronGate/Valheim/${worldname}/worlds/${worldname}.fwl /home/steam/backups/${now}/${worldname}.fwl

# clear backups older than 30 days
/usr/local/sbin/vhclearbackups.sh

# Start the Service
systemctl start valheimserver_${worldname}.service

sleep 30s

# check if service is running and post to discord if running or not
systemctl is-active --quiet valheimserver_${worldname}.service >/dev/null 2>&1 && /usr/local/sbin/discord.sh --webhook-url="${discordwebhook}" --text "Valheim Server back ONLINE! Happy gaming!" || /usr/local/sbin/discord.sh --webhook-url="${discordwebhook}" --text "Valheim Server not started. Please check..."

sleep 30s

# zip the backup and upload it to google drive
zip -j /home/steam/backups/${now}/${now}.zip /home/steam/backups/${now}/*

/root/.google-drive-upload/bin/gupload /home/steam/backups/${now}/${now}.zip
