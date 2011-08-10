#!/bin/bash
# Use ack to find some files and vim to open them.
if [ $# -gt 0 ]
then
    list=`ack $1 | awk -F : '{ print $1}' | uniq`
fi
vim $list
