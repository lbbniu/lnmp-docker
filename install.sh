#!/bin/bash

yum update --skip-broken

#yum安装
#tee /etc/yum.repos.d/docker.repo <<-'EOF'
#[dockerrepo]
#name=Docker Repository
#baseurl=https://yum.dockerproject.org/repo/main/centos/7/
#enabled=1
#gpgcheck=1
#gpgkey=https://yum.dockerproject.org/gpg
#EOF
#yum install docker-engine
#脚本安装
curl -fsSL https://get.docker.com/ | sh

#systemctl enable docker.service

#systemctl start docker

#groupadd docker
#usermod -aG docker docker
