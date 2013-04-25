if ! which apt-get; then echo "No apt-get :("; exit 1; fi
apt-get update
apt-get install mc screen htop iotop sysstat sysv-rc-conf ipcalc unp
