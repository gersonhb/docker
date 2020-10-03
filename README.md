# docker-ftp

This Docker container implements a vsftpd server, with the following features:

- Debian 10 base image.
- vsftpd 3.0.3-12
- Virtual users
- Passive mode
- SSL

# Environment variables

This image uses environment variables to allow the configuration of some parameters at run time:

- Variable name: USER
- Default value: ftp_user
- Description: Username for the default FTP account. If you don't specify it through the USER environment variable at run time, ftp_user will be used by default.
___
- Variable name: PASSWORD
- Default value: Random string.
- Description: If you don't specify a password for the default FTP account through PASSWORD, a 16 character random string will be automatically generated. You can obtain this value through the container logs.

# Exposed ports and volumes
The image exposes ports 20 and 21. Also, exports two volumes: /home/$USER, which contains users home directories, and /var/log/vsftpd, used to store logs.
