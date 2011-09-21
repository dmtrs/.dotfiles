#!/bin/bash
rm `git status | grep orig$ | awk '{print $2}'`
