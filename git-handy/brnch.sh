#!/bin/bash
#
# echo the current branch in .git

git status | grep branch | awk '{print $4}'
