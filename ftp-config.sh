#!/bin/bash

if [ "$PASSWORD" = "ftp_pass" ]; then
    export PASSWORD=`cat /dev/urandom | tr -dc A-Z-a-z-0-9 | head -c${1:-16}`
fi

mkdir /etc/vsftpd
mkdir /home/${USER}
mkdir /etc/ssl/private
mkdir /etc/ssl/certs
chown -R ftp:ftp /home/${USER}

echo -e "${USER}\n${PASSWORD}" > /etc/vsftpd/logins

file=vsftpd_virtual_logins.db
rel=`ls $file`
if [ $rel -eq 0 ];
then
	rm -fi /etc/vsftpd/$file
	db_load -T -t hash -f /etc/vsftpd/logins /etc/vsftpd/$file
	chmod 600 /etc/vsftpd/$file
else
	db_load -T -t hash -f /etc/vsftpd/logins /etc/vsftpd/$file
	chmod 600 /etc/vsftpd/$file
fi

rm /etc/vsftpd/logins

openssl req -sha256 -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/C=PE/ST=Lima/L=Lima/O=Work/OU=Org/CN=work.org"

echo "auth required pam_userdb.so db=/etc/vsftpd/vsftpd_virtual_logins" > /etc/pam.d/vsftpd
echo "account required pam_userdb.so db=/etc/vsftpd/vsftpd_virtual_logins" >> /etc/pam.d/vsftpd

/usr/sbin/vsftpd
