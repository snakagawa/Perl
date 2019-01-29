FROM centos:7

# Use systemd
RUN yum swap -y fakesystemd systemd && \
    yum install -y systemd-devel
# An error will occur if this is not done
RUN yum install -y yum-plugin-ovl

RUN yum install -y httpd \
    && yum install -y perl perl-CGI
RUN systemctl enable httpd
CMD ["/sbin/init"]