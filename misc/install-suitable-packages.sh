#!/bin/bash
if ! which apt-get; then echo "No apt-get :( Not Debian-based system?"; exit 1; fi
sudo apt-get update
sudo apt-get install tmux htop atop iotop sysstat ipcalc atool acl pv vim
sudo apt-get --no-install-recommenrs install mc
sudo update-rc.d -f atop disable
sudo sudo update-rc.d sysstat disable
