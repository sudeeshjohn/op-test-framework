#!/bin/bash
dist=$1
lst=`wget --output-document  - http://9.40.192.92:81/crtl/repo/builds/ 2>/dev/null|grep " href="|sed -r 's/^.+href="([^"]+)".+$/\1/'|egrep '^'$dist |cut -d"_" -f1-|sort -r`
#lst=`wget --output-document  - http://9.40.192.92:81/crtl/repo/builds/ 2>/dev/null|grep " href="|sed -r 's/^.+href="([^"]+)".+$/\1/'|egrep '^fedora|^rhel|^sles|^ubuntu|^centos|^pegas'|cut -d"_" -f1-|sort -r`
echo "None $lst"
