if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
fi
print "Root pw change"
passwd
echo "put in note, change other PWs"

echo "updating apache"
a2enmod userdir

	chown -R root:root /etc/apache2
	chown -R root:root /etc/apache

	if [ -e /etc/apache2/apache2.conf ]; then
		echo "<Directory />" >> /etc/apache2/apache2.conf
		echo "        AllowOverride None" >> /etc/apache2/apache2.conf
		echo "        Order Deny,Allow" >> /etc/apache2/apache2.conf
		echo "        Deny from all" >> /etc/apache2/apache2.conf
		echo "</Directory>" >> /etc/apache2/apache2.conf
		echo "UserDir disabled root" >> /etc/apache2/apache2.conf
	fi

	systemctl restart apache2.service

echo "apt updating and auto cleaning"
apt-get update
	apt-get dist-upgrade -y
	apt-get install -f -y
	apt-get autoremove -y
	apt-get autoclean -y
	apt-get check

echo "deleting useless files"
 find / -name '*.mp3' -type f -delete
	find / -name '*.mov' -type f -delete
	find / -name '*.mp4' -type f -delete
	find / -name '*.avi' -type f -delete
	find / -name '*.mpg' -type f -delete
	find / -name '*.mpeg' -type f -delete
	find / -name '*.flac' -type f -delete
	find / -name '*.m4a' -type f -delete
	find / -name '*.flv' -type f -delete
	find / -name '*.ogg' -type f -delete
	find /home -name '*.gif' -type f -delete
	find /home -name '*.png' -type f -delete
	find /home -name '*.jpg' -type f -delete
	find /home -name '*.jpeg' -type f -delete

echo "setting up ufw"
apt-get remove -y ufw
	apt-get install -y iptables
	apt-get install -y iptables-persistent
	#Backup
	mkdir /iptables/
	touch /iptables/rules.v4.bak
	touch /iptables/rules.v6.bak
	iptables-save > /iptables/rules.v4.bak
	ip6tables-save > /iptables/rules.v6.bak
	#Clear out and default iptables
	iptables -t nat -F
	iptables -t mangle -F
	iptables -t nat -X
	iptables -t mangle -X
	iptables -F
	iptables -X
	iptables -P INPUT DROP
	iptables -P FORWARD DROP
	iptables -P OUTPUT ACCEPT
	ip6tables -t nat -F
	ip6tables -t mangle -F
	ip6tables -t nat -X
	ip6tables -t mangle -X
	ip6tables -F
	ip6tables -X
	ip6tables -P INPUT DROP
	ip6tables -P FORWARD DROP
	ip6tables -P OUTPUT DROP

 
