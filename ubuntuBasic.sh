#!/bin/bash
# ufw enable
sudo apt purge ufw
sudo apt install ufw
sudo ufw enable

# remove known apps
sudo apt autoremove four-in-a-row -y
sudo apt autoremove freeciv -y
sudo apt autoremove hitori -y
sudo apt autoremove iagno -y
sudo apt autoremove hoichess -y
sudo apt autoremove lightsoff -y
sudo apt autoremove quadrapassel -y
sudo apt autoremove swell-foop -y
sudo apt autoremove aircrack-ng -y
sudo apt autoremove aisleriot -y
sudo apt autoremove bind9 -y
sudo apt autoremove bind9-host -y
sudo apt autoremove zeya -y
sudo apt autoremove yaws -y
sudo apt autoremove thin -y
sudo apt autoremove pdnsd -y
sudo apt autoremove dns2tcp -y
sudo apt autoremove gdnsd -y
sudo apt autoremove ldap2dns -y
sudo apt autoremove ophcrack -y
sudo apt autoremove nmap -y
sudo apt autoremove netris -y
sudo apt autoremove maradns -y
sudo apt autoremove minetest -y
sudo apt autoremove nsd -y
sudo apt autoremove nsd3 -y
sudo apt autoremove zentyal-dns -y
sudo apt autoremove mailutils-imap4d -y
sudo apt autoremove dovecot-pop3 -y
sudo apt autoremove dovecot-imapd -y
sudo apt autoremove cyrus-imapd -y
sudo apt autoremove cyrus-pop3 -y
sudo apt autoremove sendmail -y
sudo apt autoremove postfix -y
sudo apt autoremove sqwebmail -y
sudo apt autoremove armagetronad -y
sudo apt autoremove snmpd -y
sudo apt autoremove postgresql -y
sudo apt autoremove snmptt -y
sudo apt autoremove snmptrapfmt -y
sudo apt autoremove audacious -y
sudo apt autoremove remmina -y
sudo apt autoremove remmina-common -y
sudo apt autoremove deluge -y
sudo apt autoremove slapd -y
sudo apt autoremove iodine -y
sudo apt autoremove kismet -y
sudo apt autoremove nikto -y
sudo apt autoremove john -y
sudo apt autoremove medusa -y
sudo apt autoremove hydra -y
sudo apt autoremove tightvncserver -y
sudo apt autoremove fcrackzip -y
sudo apt autoremove telnet -y
sudo apt autoremove ayttm -y
sudo apt autoremove empathy -y
sudo apt autoremove logkeys -y
sudo apt autoremove p0f -y
sudo apt autoremove openarena -y
sudo apt autoremove netcat -y
sudo apt autoremove netcat-openbsd -y
sudo apt autoremove ettercap -y
sudo apt autoremove wireshark -y

# clamAV
sudo apt install clamav
clamscan -r --bell -i

# set up max and min passwd days
sudo sed -i '160c\PASS_MAX_DAYS	90' /etc/login.defs
sudo sed -i '161c\PASS_MIN_DAYS	30' /etc/login.defs
sudo sed -i '161c\PASS_WARN_AGE	30' /etc/login.defs

# update and upgrade
sudo apt update
sudo apt upgrade

# auditing config
sudo apt install auditd -y
sudo auditctl -e 1 -w /usr/bin/sudo -p x -k sudo_exec
sudo systemctl enable auditd
sudo systemctl start auditd

# AppArmor config
sudo apt install apparmor apparmor-profiles
sudo systemctl enable apparmor
sudo systemctl start apparmor

# Password File Configuration
sudo chmod 0644 /etc/passwd
sudo chown root /etc/passwd
sudo chgrp root /etc/passwd
sudo chmod 640 /etc/shadow
sudo chown root /etc/shadow

# Sudoers File Configuration
sudo chmod root /etc/sudoers
sudo chown root /etc/sudoers
sudo chgrp root /etc/sudoers
sudo chmod root /etc/sudoers
sudo chown root /etc/sudoers
