noblacklist ${HOME}/.Upwork
mkdir ${HOME}/.Upwork
whitelist ${HOME}/.Upwork

noblacklist ${HOME}/.config/Upwork
mkdir ${HOME}/.config/Upwork
whitelist ${HOME}/.config/Upwork

noblacklist ${HOME}/.cache/Upwork
mkdir ${HOME}/.cache/Upwork
whitelist ${HOME}/.cache/Upwork

noblacklist ${HOME}/.pki
mkdir ${HOME}/.pki
whitelist ${HOME}/.pki

# Session configuration: fonts, themes, gtk, ...
include /etc/firejail/whitelist-common.inc

protocol unix,inet,inet6,netlink

# Security filters
include /etc/firejail/default.profile

