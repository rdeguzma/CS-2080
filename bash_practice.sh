#!/usr/bin/env bash
#
# Copyright (c) Vijay Banerjee 10-29-24
#
#

# We have already seen a few common bash commands.
# We will not take it a step further and write a full bash script using
# different bash features.
#

# Using variables
variable_name="something"

############
# Write the command to print this variable
echo "$variable_name"
############
# Now print the following using the variable
# "Here is the value of the variable: something"
echo "Here is the value of the variable: $variable_name"
###########

# We learned that output of a command is a stream of data that can be treated as
# a file. Similar to printing a variable, we can also use some other commands
# and use the output of the command into your text string
#
# Write the command to print the present working directory with the following
# string
# "I am currently in this directory: <name of the present working directory>"
echo "I am currently in this directory: $(pwd)"
##########

# Pointing to another variable using !
name="alice"
someone=name

# Now ${!someone} would reference to variable $name. Print something using the
# variable someone to instead of name, to print "alice"
echo "My name is ${!someone}"

# The use of special symbols to manipulate the variables is called shell
# expansion
# We have already seen some other types of shell expansions like
#  '~' exphands into the home directory
#  '`' (backtick) executes the command inside it
#  '(( ))' arithmetic expression evaluation like $((5+6))
#
#  There are seven such expansions that are more formally listed as:
#  brace expansion
#  tilde expansion
#  parameter and variable expansion
#  command substitution
#  arithmetic expansion
#  word splitting
#  filename expansion
#
#  The best place to read more is: https://www.gnu.org/software/bash/manual/bash.html#Shell-Expansions
#
#  Instead of going through each of these, we will notice their use when a
#  usecase arises
#

# Functions
#

printit(){
    echo "my name is $1" #Taking the first parameter passed
    echo "Our names are  $*" #Taking all parameters
}

printit alice bob


# Conditional

# syntax is
# if some-command; then
#    <Do something here if command is true>
# elif some-other-command; then
#    <Do the other thing here>
# else <Do something if nothing else is true>
# fi 
#
# Remember to close the block with fi

#
# Write a function called "cond_test" that takes two inputs
# If the first input is similar to second input, it will print "hello"
# else it will print "bye"

cond_test(){
	if[[ $1 == $2 ]]; then
		echo "hello"
	else
		echo "bye"
	fi
}

cond_test attempt attempt
cond_test attempt fail


# To check if the strings are equal, use the following command
#
# [[ input1 == input2 ]] 
# In bash [[ ]] is basically a command that evaluates wheter or not the
# statement inside is true. Some other common conditionals are
#
# [[ -n STRING ]] check if string is not empty
# [[ STRING != STRING ]] 
# [[ number -eq number2 ]] to check if two numbers are equal
# [[ number -lt number2 ]] less than
# [[ number -gt number2 ]] greater than
# [[ number -ge number2 ]] greater than or equal to
# (( number > number2 )) evaluate the math and return something

# Now write a function that prints two numbers on screen and takes an input. if
# the input equals to the sum of the two number, it prints "correct" else it
# prints "incorrect"

my_function(){
	num1=5
	num2=6
	read -p "What is the sum of $num1 and $num2? " answer
	if [[ $answer -eq $((num1 + num2)) ]]; then
		echo "correct"
	else
		echo "incorrect"
	fi
}


############################
# Once done with it 
# Use a while loop
# while :
# do
#     something
# done
# 
# to write the previous function with an infinite loop
# This time, generate random two numbers and check if the input sum is correct
#
# Note $RANDOM gives a big random number. But taking a modulo of that number
# with any number n would ensure that the random number is always within the
# range of 1-n
loop_function(){
while :
do
	num1=$((RANDOM % 10 + 1))
	num2=$((RANDOM % 10 + 1))
	read -p "What is the sum of $num1 and $num2? " answer
	if [[ $answer -eq $((num1 + num2)) ]]; then
		echo "correct"
	else
		echo "incorrect"
	fi
done
}



