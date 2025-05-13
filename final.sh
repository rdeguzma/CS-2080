#! /usr/bin/env/ bash

#####################
# Copyright (c) Reyes Deguzman 13 May 2025
#


#1a.
uname -v

#1b.
uname -a | awk '{print $4}'

#1c.
bash --version | head -n1 | awk '{print $4}'

#1d.
ps

#1e.
ls -l final.sh | awk '{print $1}'


#2a.
#create group test_users
sudo groupadd test_users
#create users and add to group
sudo useradd -m -G test_users alice
sudo useradd -m -G test_users bob
#list groups of alice and bob
sudo groups alice
sudo groups bob

#2b.
#change ownership to alice and create files and directory
sudo chown alice: /home/alice
sudo -u alice touch /home/alice/alice.txt
sudo -u alice touch /home/alice/bob.txt
sudo -u alice touch /home/alice/both.txt
sudo -u alice mkdir /home/alice/docker_test
#list /home/alice files
sudo -u alice ls -l  /home/alice

#2c
#change ownership of alice.txt and both.txt to alice
sudo chown alice: /home/alice/alice.txt
sudo chown alice: /home/alice/both.txt
#change ownership of bob.txt to bob
sudo chown bob: /home/alice/bob.txt
#change group of docker_test directory to test_users
sudo chgrp test_users /home/alice/docker_test

#2d
#write sample line in alice.txt as alice
#use acl to give bob permission to read and write alice.txt

#write into alice.txt as alice
sudo -u alice bash -c 'echo "This is a test line." > /home/alice/alice.txt'
#install acl
sudo apt install acl
#give bob rw permissions
sudo setfacl -m u:bob:rw /home/alice/alice.txt
#get acl for alice.txt
sudo getfacl /home/alice/alice.txt
#have bob read the file
sudo -u bob cat /home/alice/alice.txt

#3a
#change to alice docker_test directory
cd /home/alice/docker_test

#init Git repository
sudo -u alice git init /home/alice/docker_test

#create dockerfile using echo
sudo -u alice touch /home/alice/docker_test/Dockerfile
sudo -u alice bash -c 'echo "FROM ubuntu" > /home/alice/docker_test/Dockerfile'
sudo -u alice bash -c 'echo "RUN apt install nginx" >> /home/alice/docker_test/Dockerfile'
sudo -u alice touch /home/alice/docker_test/app.sh



#create 

