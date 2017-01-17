if ! which apt-get; then echo "No apt-get :( Not Debian-based distro?"; exit 1; fi
sudo apt-get update
sudo apt-get install mc screen tmux htop atop iotop sysstat ipcalc sipcalc unp acl pv vim
sudo update-rc.d -f atop disable
sudo sudo update-rc.d sysstat disable

