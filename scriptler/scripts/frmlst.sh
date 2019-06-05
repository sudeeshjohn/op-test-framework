#!/bin/sh
lst=`wget --output-document  - http://ltc-jenkins.aus.stglabs.ibm.com:81/crtl/repo/builds/ 2>/dev/null|grep " href="|sed -r 's/^.+href="([^"]+)".+$/\1/'|egrep '^opal|^OpenPower'|cut -d"_" -f2-|sort -r`
pnorlst=`wget --output-document  - http://ltc-jenkins.aus.stglabs.ibm.com:81/crtl/repo/builds/ 2>/dev/null|grep " href="|sed -r 's/^.+href="([^"]+)".+$/\1/'|grep '^pnor'|sort -r`
skibootlst=`wget --output-document  - http://ltc-jenkins.aus.stglabs.ibm.com:81/crtl/repo/builds/ 2>/dev/null|grep " href="|sed -r 's/^.+href="([^"]+)".+$/\1/'|grep '^Skiboot'|sort -r`
echo "None $lst $pnorlst $skibootlst"
