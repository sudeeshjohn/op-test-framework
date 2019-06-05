#!/bin/bash
lst=`wget --output-document  - http://ltc-jenkins.aus.stglabs.ibm.com:81/crtl/repo/builds/ 2>/dev/null|grep " href="|sed -r 's/^.+href="([^"]+)".+$/\1/'|grep '^pkvm'|cut -d"_" -f2-|sort -r`
echo "None $lst"
