# valheim-server-backup
Automatic Backup for your Valheim Server worlds with 30 day history and automated Discord notifications.

## Getting Started

### Prerequisites

This backup method uses the Dedicated Valheim Server Script from Nimdy:

* [Dedicated_Valheim_Server_Script](https://github.com/Nimdy/Dedicated_Valheim_Server_Script) - Valheim Installer and Menu System for managing your Valheim Dedicated Server. Supports Vanilla or Mod modes. Built on Ubuntu 20.04.


## Usage

### 1. Get the scripts

1. Download (or clone) a copy of `valheim-server-backup`
2. Place the scripts in `/usr/local/sbin/`or wherever you want. Be sure to set all the paths correctly if you do so
3. Give files execution permissions

```sh
chmod +x /usr/local/sbin/discord.sh
chmod +x /usr/local/sbin/vhclearbackups.sh
chmod +x /usr/local/sbin/vhserverbackup.sh
```

### 2. Set world name

1. Edit line 4 of `vhserverbackup.sh` and replace ENTERWORLDNAMEHERE with your world name to be backed up

### 3. Set up a crontab to automate execution

1. Edit crontabs

```sh
crontab -e
```

2. On a new line place following code (this runs the backup every morning at 5am)

```sh
0 5 * * * /usr/local/sbin/vhserverbackup.sh
```

You can set the time an occurence to whatever you like. You'll find some help at [crontab.guru](https://crontab.guru/).


### 4. Setting up a Discord webhook.

1. [Setup a webhook](https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks) in the desired Discord text channel
2. Edit Line 3 of `vhserverbackup.sh` and set your webhook URL


### To-Dos

* Upload backups to remote destination like gdrive

## Built With

* [discord.sh](https://github.com/ChaoticWeg/discord.sh) - Write-only command-line Discord webhook integration written in 100% Bash script

### Inspiration from
* [ValheimBackupandNotifications](https://github.com/aremedis/ValheimBackupandNotifications) - Script for daily backups of Valheim Dedicated server, and sending notifications to Discord.
* [Geekhead YouTube tutorial for Backups](https://www.youtube.com/watch?v=XejBIwBYTG8&t=84s)
