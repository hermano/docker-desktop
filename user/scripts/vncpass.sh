#!/bin/sh

prog=/usr/bin/vncpasswd
mypass=$VNCPASS

/usr/bin/expect <<EOF
spawn "$prog"
expect "Password:"
send "$mypass\r"
expect "Verify:"
send "$mypass\r"
sleep 1
send "$mypass\r"
expect eof
exit
EOF