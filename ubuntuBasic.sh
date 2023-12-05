#!/bin/bash
# ufw enable
sudo apt purge ufw
sudo apt install ufw
sudo ufw enable

# remove known apps
sudo apt purge four-in-a-row -y
sudo apt purge freeciv -y
sudo apt purge hitori -y
sudo apt purge iagno -y
sudo apt purge hoichess -y
sudo apt purge lightsoff -y
sudo apt purge quadrapassel -y
sudo apt purge swell-foop -y
sudo apt purge aircrack-ng -y
sudo apt purge aisleriot -y
sudo apt purge bind9 -y
sudo apt purge bind9-host -y
sudo apt purge zeya -y
sudo apt purge yaws -y
sudo apt purge thin -y
sudo apt purge pdnsd -y
sudo apt purge dns2tcp -y
sudo apt purge gdnsd -y
sudo apt purge ldap2dns -y
sudo apt purge ophcrack -y
sudo apt purge nmap -y
sudo apt purge netris -y
sudo apt purge maradns -y
sudo apt purge minetest -y
sudo apt purge nsd -y
sudo apt purge nsd3 -y
sudo apt purge zentyal-dns -y
sudo apt purge mailutils-imap4d -y
sudo apt purge dovecot-pop3 -y
sudo apt purge dovecot-imapd -y
sudo apt purge cyrus-imapd -y
sudo apt purge cyrus-pop3 -y
sudo apt purge sendmail -y
sudo apt purge postfix -y
sudo apt purge sqwebmail -y
sudo apt purge armagetronad -y
sudo apt purge snmpd -y
sudo apt purge postgresql -y
sudo apt purge snmptt -y
sudo apt purge snmptrapfmt -y
sudo apt purge audacious -y
sudo apt purge remmina -y
sudo apt purge remmina-common -y
sudo apt purge deluge -y
sudo apt purge slapd -y
sudo apt purge iodine -y
sudo apt purge kismet -y
sudo apt purge nikto -y
sudo apt purge john -y
sudo apt purge medusa -y
sudo apt purge hydra -y
sudo apt purge tightvncserver -y
sudo apt purge fcrackzip -y
sudo apt purge telnet -y
sudo apt purge ayttm -y
sudo apt purge empathy -y
sudo apt purge logkeys -y
sudo apt purge p0f -y
sudo apt purge openarena -y
sudo apt purge netcat -y
sudo apt purge netcat-openbsd -y
sudo apt purge ettercap -y
sudo apt purge wireshark -y

# clamAV
sudo apt install clamav
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
sudo chmod 640 /etc/shadow
sudo chown root /etc/shadow

