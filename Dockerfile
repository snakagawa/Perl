FROM centos:7

# Use systemd
RUN yum swap -y fakesystemd systemd && \
    yum install -y systemd-devel
# An error will occur if this is not done
RUN yum install -y yum-plugin-ovl
# Install Apach & Perl
RUN yum install -y httpd \
    && yum install -y perl perl-CGI \
    && yum install -y perl-App-cpanminus \
    && yum install -y gcc
# Install Camelcadedb
RUN cpanm Hash::StoredIterator \
    && cpanm PadWalker \
    && cpanm JSON::XS \
    && cpanm Devel::Camelcadedb
# Create Perl Wrapper File For Remote Debug
RUN echo -e '#!/bin/bash\n\n/usr/bin/perl -d:Camelcadedb ${1} 2>/dev/null\nexit 0' > /usr/local/bin/perl \
    && chmod 755 /usr/local/bin/perl
# Enable Apach
RUN systemctl enable httpd
CMD ["/sbin/init"]