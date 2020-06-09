FROM ubuntu:18.04

RUN echo "Europe/Berlin" > /etc/timezone
# RUN sudo ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime

RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends tzdata

RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /

# Install packages for minimal Desktop
RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends wget curl rsync netcat mg vim bzip2 zip unzip gpg && \
    apt-get install -yqq openbox tightvncserver novnc net-tools x11-apps && \
    apt-get install -y --no-install-recommends xterm firefox chromium-browser htop && \
    apt-get install -y --no-install-recommends python-pip && \
    apt-get install -y --no-install-recommends libssl-dev && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install vscode
WORKDIR /root/
RUN apt-get install apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list && \
    apt-get update -q && \
    apt-get install code -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Add user to the system
RUN useradd -ms /bin/bash student


# Add aspecial files to the user (and to root)
WORKDIR /
ADD root-home.tar.gz /
ADD student-home.tar.gz /
# Correlt the ownerships of files
RUN chown -R root:root /root && \ 
    chown root:root /home && \
    chown -R student:student /home/student


RUN echo "mycontainer" > /etc/hostname
RUN echo "127.0.0.1	localhost" > /etc/hosts
RUN echo "127.0.0.1	mycontainer" >> /etc/hosts

USER student
WORKDIR /home/student

# Copy an manipulate a needed library for vscode
RUN export PATH=$PATH:~/scripts & \
    mkdir ~/lib && \
    cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 ~/lib && \
    sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' ~/lib/libxcb.so.1

RUN echo "1~_?o?BV?" > .vnc/passwd

EXPOSE 5901
EXPOSE 6081
ENV USER student
CMD [ "./start-vncserver.sh" ]
