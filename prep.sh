#!/bin/bash

if [ "$EUID" -eq 0 ]
  then echo "Please do not run this script as root or using sudo"
  exit
fi

# # ---Create user account----

    if id -u "$1000" >/dev/null 2>&1; then
      echo "plex user exists"
    else
      echo "plex user does not exist adding user"
      sudo useradd -m plex -u 1000 -g 1000
      sudo echo castleredTuesday6! | passwd plex --stdin
    fi



sudo apt remove docker docker-engine docker.io containerd runc
sudo snap remove docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo curl -s https://api.github.com/repos/docker/compose/releases/latest | grep "browser_download_url" | grep -i -m1 `uname -s`-`uname -m` | cut -d '"' -f4 | xargs sudo curl -L -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v
sudo usermod -aG docker plex
