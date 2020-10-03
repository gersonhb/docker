FROM debian:10

RUN apt update && apt install -y vsftpd db-util

COPY ftp-config.sh /usr/sbin
COPY vsftpd.conf /etc/

EXPOSE 20 21

ENV USER ftp_user
ENV PASSWORD ftp_pass

VOLUME /home/$USER
VOLUME /var/log/vsftpd

RUN chmod +x /usr/sbin/ftp-config.sh
RUN mkdir -p /home/vsftpd/ && mkdir /var/vsftpd
RUN chown -R ftp:ftp /home/vsftpd/ && chown -R ftp:ftp /var/vsftpd

CMD bash /usr/sbin/ftp-config.sh
