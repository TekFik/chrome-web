# Pull base image.
FROM tekfik/os:centos7-systemd
MAINTAINER <TekFik - www.tekfik.com> tekfik.rd@gmail.com 

COPY system /etc/systemd/system/
COPY yum/google-chrome.repo /etc/yum.repos.d/

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm; yum -y update all; \
    yum -y install tigervnc-server-minimal novnc google-chrome-stable alsa-firmware alsa-lib alsa-tools-firmware; \
    yum -y clean all; rm -rf /var/tmp/* /tmp/* /var/cache/yum/*

RUN /sbin/useradd app;cd /etc/systemd/system/multi-user.target.wants; \
    ln -sf /etc/systemd/system/tgvnc.service tgvnc.service; \    
    ln -sf /etc/systemd/system/chrome.service chrome.service; \
    ln -sf /etc/systemd/system/novnc.service novnc.service;\
    cd /usr/share/novnc; rm -rf index.html

COPY index.html /usr/share/novnc

# Define working directory.
WORKDIR /tmp

# Metadata.
LABEL \
      org.label-schema.name="chrome" \
      org.label-schema.description="Docker container for Google-Chrome" \
      org.label-schema.version="Centos7.7"

#EXPOSE 3000 

CMD ["/usr/sbin/init"]
