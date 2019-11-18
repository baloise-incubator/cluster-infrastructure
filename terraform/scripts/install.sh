#!/bin/bash
cd ~
chmod 600 ~/.ssh/id_rsa
yum -y install git ansible
ssh-keyscan github.com >> githubKey
ssh-keygen -lf githubKey
cat githubKey >> ~/.ssh/known_hosts

git clone git@github.com:baloise-incubator/cluster-infrastructure.git
git clone --single-branch --branch release-3.11 git@github.com:openshift/openshift-ansible.git