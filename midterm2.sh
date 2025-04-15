#!/bin/bash
#Copyright Reyes Deguzman 04/15/2025

#check for root priveleges
if [ "$EUID" -ne 0 ]

then echo "Run as root!"

	exit

fi

#creating and assigning users and groups
useradd alice
useradd bob
useradd charlie
useradd dave
useradd emily
groupadd web
groupadd accounts
groupadd management

#assigning alice and bob to web
usermod -a -G web alice
usermod -a -G web bob

#assigning charlie and dave to accounts
usermod -a -G accounts charlie
usermod -a -G accounts dave

#assigning dave and emily to management
usermod -a -G management dave
usermod -a -G management emily

#File ops
#for loop to create 3 files each with "hello" in first line
for i in 1 2 3;
do
	echo "Hello" > "test_file$i.txt" 

done

#for loop to change ownership of alice for all 3 test files
for i in 1 2 3;
do
	chown alice "test_file$i.txt"

done

#list permissions of the file
ls -l 

#assign the groups to files
chgrp web test_file1.txt
chgrp accounts test_file2.txt
chgrp management test_file3.txt

ls -la

#using sudo command write to testfile1 from alice
sudo -u alice bash -c "echo 'hello from alice' >> test_file1.txt"
cat test_file1.txt

#give read access of test file 1 to dave and print access control list related to test file 1
#download acl
apt install acl

#get list of permissions
getfacl test_file1.txt

#give dave read permissions
setfacl -m dave:r test_file1.txt

#grep Hello from dave
sudo -u dave grep -n "Hello" test_file1.txt

#ping, textstream, open-source CLI tools
ping -c3 ec2.us-west-1.amazonaws.com | grep rtt
ping -c3 ec2.us-west-2.amazonaws.com | grep rtt
ping -c3 ec2.us-east-1.amazonaws.com | grep rtt
ping -c3 ec2.us-east-2.amazonaws.com | grep rtt
ping -c3 ec2.ca-central-1.amazonaws.com | grep rtt


#from Alice profile, write these lines into pingtest file so that each line starts with name of server
#and then string containing only the average value of RTT. Print using cat
touch pingtest

sudo -u alice bash -c "ping -c3 ec2.us-west-1.amazonaws.com | grep rtt | awk -F'/' '{ print $5 } >> pingtest"
sudo -u alice bash -c "ping -c3 ec2.us-west-2.amazonaws.com | grep rtt | awk -F'/' '{ print $5 } >> pingtest"
sudo -u alice bash -c "ping -c3 ec2.us-east-1.amazonaws.com | grep rtt | awk -F'/' '{ print $5 } >> pingtest"
sudo -u alice bash -c "ping -c3 ec2.us-east-2.amazonaws.com | grep rtt | awk -F'/' '{ print $5 } >> pingtest"
sudo -u alice bash -c "ping -c3 ec2.ca-central-1.amazonaws.com | grep rtt | awk -F'/' '{ print $5 } >> pingtest"

#print pingtest
cat pingtest

#install gnuplot
sudo apt install gnuplot

#make xfs filesystem, mount at mount point /mnt/ping
mkfs.xfs /dev/device
mkdir /mnt/ping
mount /mnt/ping

#copy pingtest file into ping directory and change ownership of Bob, management
cp pingtest /mnt/ping
chown bob /mnt/ping/pingtest
chgrp management /mnt/ping/pingtest

#print using dave's profile
sudo -u dave cat /mnt/ping/pingtest

#run gnuplot from bob's profile
sudo -u bob gnuplot << EOF
set boxwidth 0.5
set style fill solid
plot "/mnt/ping/pingtest" using 2:xtic(1) with boxes
EOF


