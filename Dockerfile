FROM ubuntu:16.04

ARG playbook
ADD $playbook ./

MAINTAINER Erik Liland <erik.liland@embida.no>

ARG VERSION=0.6
ARG user=ubuntu
ARG group=ubuntu
ARG uid=1000
ARG gid=1000
ENV HOME /home/${user}
RUN groupadd -g ${gid} ${group}
RUN useradd -c "Jenkins user" -d $HOME -u ${uid} -g ${gid} -m ${user}
LABEL Description="This is an Intel Quartus image with Intel EDS" Vendor="Embida AS" Version="${VERSION}"

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-get -qq update
RUN apt-get -qq install -q -y ansible
RUN ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml
RUN rm -f playbook.yml
RUN echo ${PATH}
ENV PATH="${PATH}"

USER ${user}
RUN mkdir /home/${user}/
WORKDIR /home/${user}
