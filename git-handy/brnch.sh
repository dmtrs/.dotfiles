#!/bin/bash
#
# echo the current branch in .git

git branch | grep \* | awk '{print $2}'
