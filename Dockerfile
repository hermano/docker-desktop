FROM ubuntu:18.04

RUN echo "Europe/Berlin" > /etc/timezone
# RUN sudo ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime

RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends tzdata

RUN dpkg-reconfigure -f noninteractive tzdata

# Install packages
RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends wget curl rsync netcat mg vim bzip2 zip unzip && \
    apt-get install -yqq openbox tightvncserver novnc net-tools x11-apps && \
    apt-get install -y --no-install-recommends xterm firefox chromium-browser htop && \
    apt-get install -y --no-install-recommends python-pip && \
    apt-get install -y --no-install-recommends libssl-dev && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /

ADD root-home.tar.gz /

RUN echo "mycontainer" > /etc/hostname
RUN echo "127.0.0.1	localhost" > /etc/hosts
RUN echo "127.0.0.1	mycontainer" >> /etc/hosts

# RUN rm -R /root/.vnc

EXPOSE 5901
EXPOSE 6081
ENV USER root
CMD [ "/root/start-vncserver.sh" ]
