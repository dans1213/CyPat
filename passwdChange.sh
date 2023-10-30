#!/usr/bin/expect
# http://stackoverflow.com/questions/27837674/changing-a-linux-password-via-script

# Usage:
# passwdChange <username> <oldpassword> <newpassword>

set username [lindex $argv 0]
set oldpassword [lindex $argv 1]
set newpassword [lindex $argv 2]

passwd
expect "assword:"
send "$password\r"
expect "UNIX password:"
send "$password\r"
expect "password:"
send "$newpassword\r"
expect "password:"
send "$newpassword\r"
expect eof
