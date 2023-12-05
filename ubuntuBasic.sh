#!/bin/bash
# ufw enable
sudo apt purge ufw
sudo apt install ufw
sudo ufw enable

# remove known apps
sudo apt-get --purge four-in-a-row -y
sudo apt-get --purge freeciv -y
sudo apt-get --purge hitori -y
sudo apt-get --purge iagno -y
sudo apt-get --purge hoichess -y
sudo apt-get --purge lightsoff -y
sudo apt-get --purge quadrapassel -y
sudo apt-get --purge swell-foop -y
sudo apt-get --purge aircrack-ng -y
sudo apt-get --purge aisleriot -y
sudo apt-get --purge bind9 -y
sudo apt-get --purge bind9-host -y
sudo apt-get --purge zeya -y
sudo apt-get --purge yaws -y
sudo apt-get --purge thin -y
sudo apt-get --purge pdnsd -y
sudo apt-get --purge dns2tcp -y
sudo apt-get --purge gdnsd -y
sudo apt-get --purge ldap2dns -y
sudo apt-get --purge ophcrack -y
sudo apt-get --purge nmap -y
sudo apt-get --purge netris -y
sudo apt-get --purge maradns -y
sudo apt-get --purge minetest -y
sudo apt-get --purge nsd -y
sudo apt-get --purge nsd3 -y
sudo apt-get --purge zentyal-dns -y
sudo apt-get --purge mailutils-imap4d -y
sudo apt-get --purge dovecot-pop3 -y
sudo apt-get --purge dovecot-imapd -y
sudo apt-get --purge cyrus-imapd -y
sudo apt-get --purge cyrus-pop3 -y
sudo apt-get --purge sendmail -y
sudo apt-get --purge postfix -y
sudo apt-get --purge sqwebmail -y
sudo apt-get --purge armagetronad -y
sudo apt-get --purge snmpd -y
sudo apt-get --purge postgresql -y
sudo apt-get --purge snmptt -y
sudo apt-get --purge snmptrapfmt -y
sudo apt-get --purge audacious -y
sudo apt-get --purge remmina -y
sudo apt-get --purge remmina-common -y
sudo apt-get --purge deluge -y
sudo apt-get --purge slapd -y
sudo apt-get --purge iodine -y
sudo apt-get --purge kismet -y
sudo apt-get --purge nikto -y
sudo apt-get --purge john -y
sudo apt-get --purge medusa -y
sudo apt-get --purge hydra -y
sudo apt-get --purge tightvncserver -y
sudo apt-get --purge fcrackzip -y
sudo apt-get --purge telnet -y
sudo apt-get --purge ayttm -y
sudo apt-get --purge empathy -y
sudo apt-get --purge logkeys -y
sudo apt-get --purge p0f -y
sudo apt-get --purge openarena -y
sudo apt-get --purge netcat -y
sudo apt-get --purge netcat-openbsd -y
sudo apt-get --purge ettercap -y
sudo apt-get --purge wireshark -y

# clamAV
sudo apt intall clamav
sudo freshclam
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
Sudo chmod 640 /etc/shadow
Sudo chown root /etc/shadow

