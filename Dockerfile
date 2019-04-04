FROM ubuntu:16.04

ARG playbook
ADD $playbook ./

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-get -qq update
RUN apt-get -qq install -q -y ansible
RUN ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml
RUN rm -f playbook.yml
ENV PATH="/opt/intelFPGA/quartus/bin:${PATH}"
ENV PATH="/usr/local/DS-5_v5.29.1/bin:${PATH}"
