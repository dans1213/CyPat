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

 
echo "Installing auditing daemon"
    apt-get install auditd -y
    echo "enabling auditing"
    auditctl -e 1 > /var/local/audit.log

echo "installing libpam-cracklib for passwords"
    apt-get install libpam-cracklib -y
    

echo "changing PAM config"

#grep for 'pam_unix.so' and get line number
PAMUNIX="$(grep -n 'pam_unix.so' /etc/pam.d/common-password | grep -v '#' | cut -f1 -d:)"
sed -e "${PAMUNIX}s/.*/password	[success=1 default=ignore]	pam_unix.so obscure use_authtok try_first_pass sha512 remember=5/" /etc/pam.d/common-password > /var/local/temp.txt

#grep for 'pam_cracklib.so' and get line number
PAMCRACKLIB="$(grep -n 'pam_cracklib.so' /etc/pam.d/common-password | grep -v '#' | cut -f1 -d:)"
sed -e "${PAMCRACKLIB}s/.*/password	requisite	pam_cracklib.so retry=3 minlen=8 difok=3 ucredit=-1 1credit=-2 ocredit=-1/" /var/local/temp.txt > /var/local/temp2.txt
rm /var/local/temp.txt
mv /etc/pam.d/common-password /etc/pam.d/common-password.old
mv /var/local/temp2.txt /etc/pam.d/common-password

echo "setting passwords to reset after 30 days"
    PASSMAX="$(grep -n 'PASS_MAX_DAYS' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSMAX}s/.*/PASS_MAX_DAYS	90/" /etc/login.defs > /var/local/temp1.txt
    PASSMIN="$(grep -n 'PASS_MIN_DAYS' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSMIN}s/.*/PASS_MIN_DAYS	10/" /var/local/temp1.txt > /var/local/temp2.txt
    PASSWARN="$(grep -n 'PASS_WARN_AGE' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSWARN}s/.*/PASS_WARN_AGE	7/" /var/local/temp2.txt > /var/local/temp3.txt
    mv /etc/login.defs /etc/login.defs.old
    mv /var/local/temp3.txt /etc/login.defs
    rm /var/local/temp1.txt /var/local/temp2.txt

    echo "installing clam antivirus"
    apt-get install clamav -y
    #Update clam signatures
    echo "updating clam signatures"
    freshclam

   #Run a full scan of the "/home" directory
    echo "running full scan of /home directory"
    clamscan -r /home
