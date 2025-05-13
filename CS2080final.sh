#! /usr/bin/env bash

###################
# Copyright (c) Reyes Deguzman 13 May 2025
#

printf "
1. Answer the following questions using Unix user commands (50 points)
   Using sed and awk to trim the output of commands to provide the exact answer
   will get 10%% extra points on each question\n\n"

printf "
    a. What is the current version of Linux kernel you are using?\n" 
uname -v
printf "
    b. Print the linux distribution that you are using\n\n"
uname -a | awk '{print $4}'
printf "
    c. What is the current version of bash you are using?\n\n"
bash --version | head -n1 | awk '{print $4}'
printf "
    d. What is the PID of the current bash process?\n\n" 
ps
printf "
    e. Print the file permission string of this script\n"
ls -l CS2080final.sh | awk '{print $1}'

printf "
2. Write the commands to do the following filesystem operations (150
points)\n"

printf "
    a. Create two users : alice and bob and add them to a group called
       test_users
       After executing the commands, use sudo command to print the
       groups of alice and bob. (Remember to create each user with thier respective
       home directory)(20 points)\n"
#create group       
sudo groupadd test_users
#create users and add to group
sudo useradd -m -G test_users alice
sudo useradd -m -G test_users bob
#list groups of alice and bob
sudo groups alice
sudo groups bob
printf "
    b. Create the following three empty files and one directory inside /home/alice/ :%s \n\n" "
          alice.txt bob.txt both.txt
          docker_test/

          List the created files using list command (30 points)"
#change ownership to alice and create files and directory
sudo chown alice: /home/alice
sudo -u alice touch /home/alice/alice.txt
sudo -u alice touch /home/alice/bob.txt
sudo -u alice touch /home/alice/both.txt
sudo -u alice mkdir /home/alice/docker_test

#list 
sudo -u alice ls -l /home/alice
printf "
    c. Make alice the owner of the files alice.txt and both.txt
       Make bob the owner of bob.txt
       Change the effective groups of the directory to
       test_users (30 points)\n"
#change ownership of alice.txt and both.txt to alice
sudo chown alice: /home/alice/alice.txt
sudo chown alice: /home/alice/both.txt
#change ownership of bob.txt to bob
sudo chown bob: /home/alice/bob.txt
#change group of docker_test directory to test_users
sudo chgrp test_users /home/alice/docker_test
printf "
    d. Write a sample line of text in alice.txt from alice's profile and using
       access control list, give bob permission to read and write the contents of alice.txt
    
       Print the current ACL for alice.txt and run cat on alice.txt from bob's
       profile (70 points). \n"
#write into alice.txt as alice
sudo -u alice bash -c 'echo "This is a test line." > /home/alice/alice.txt'
#install acl
sudo apt install acl
#give bob rw permission
sudo setfacl -m u:bob:rw /home/alice/alice.txt
#get acl for alice.txt
sudo getfacl /home/alice/alice.txt
#have bob read the file
sudo -u bob cat /home/alice/alice.txt
printf "
\n\n
3. Initialize /home/alice/docker_test as a git repository and do the following
(50 points):

    * Create an empty file named Docker file
    * Using echo, populate the Docker file to use the official ubuntu image
      and install nginx in that instance. (You can use previous assignments as an example)
    * Create an empty file app.sh
    * Populate app.sh
      use sed to add the following line in the file
      /var/www/html/*.html
    
      <p> This is the final exam submission of YOUR_FIRST_NAME on May 13th </p>
    
    Hint: The line number to enter this can be found using the command in the 
    comment in line 77:"
    
   #linenum=$(($(cat *.html -n | tail -1 | awk '{print $1}') - 2))

cd /home/alice/docker_test
sudo -u alice git init /home/alice/docker_test
sudo -u alice bash -c 'echo "FROM ubunut" > /home/alice/docker_test/Dockerfile'
sudo -u alice bash -c 'echo "RUN apt install nginx" >> /home/alice/docker_test/Dockerfile'

sudo -u alice bash -c 'echo "touch /home/alice/docker_test/app.sh"'
sudo -u alice bash -c 'echo "#!/bin/bash" > /home/alice/docker_test/app.sh'
sudo -u alice bash -c 'echo "linenum=$(($(cat *.html -n | tail -1 | awk '{print $1}') -2))" >> /home/alice/docker_test/app.sh'
sudo -u alice bash -c 'echo "sed -i \"\${linenum}a <p> This is the final exam submission of REYES on May 13th </p>\" /var/www/html/*.html" >> /home/alice/docker_test/app.sh'
sudo -u alice bash -c 'echo "sudo systemctl restart nginx" >> /home/alice/docker_test/app.sh'

sudo -u alice git add /home/alice/docker_test/Dockerfile
sudo -u alice git add /home/alice/docker_test/app.sh
sudo -u alice git commit -m "Alice dockerfile and app.sh"
sudo -u alice git push

    printf "
    \n
      Restart the nginx server from the app script
    
    * Commit all these new addition with a git commit message
    * print the git log here\n\n"

