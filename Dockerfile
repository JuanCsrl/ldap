FROM centos/systemd
RUN  yum -y install openldap 
RUN  yum -y install openldap-clients
RUN  yum -y install openldap-servers 
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
RUN systemctl enable slapd
COPY . /home
WORKDIR /home
RUN chown -R root:root /home
RUN chmod -R 777 /home
USER root
CMD ["/usr/sbin/init"]