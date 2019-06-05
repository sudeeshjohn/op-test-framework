#!/bin/sh
set -x
iso=`ls *.iso`
cobhost=$1
#cobhost=$1:8000
#cobhost='9.3.190.175'
mac=$2
#mac='5c:f3:fc:5d:12:f8'
ip=$3
#ip='9.3.190.100'
#kargs="kvmp.inst.action=install kvmp.inst.disk=/dev/sda"
kargs=$4
export cobrep=${cobhost}/cobbler/ks_mirror/${iso}-distro-ppc64
mkdir mnt
mount $iso mnt -o loop
dispath='/var/www'
#dispath='/var/www/html'
if [[ ! -d $dispath/cobbler/ks_mirror/${iso}-distro-ppc64/ ]];then mkdir -p $dispath/cobbler/ks_mirror/${iso}-distro-ppc64/;cp -r mnt/* $dispath/cobbler/ks_mirror/${iso}-distro-ppc64/;fi
mac=$(echo "01-"`echo $mac|sed s/:/-/g`)
touch $dispath/cobbler/ks_mirror/$mac
lnx_path=`find mnt/|grep vmlinuz`
lnx_var=${lnx_path#*/}
init_path=`find mnt/|grep initrd`
init_var=${init_path#*/}
netinst=$dispath/cobbler/ks_mirror/$mac
ksinst=$dispath/cobbler/ks_mirror/$mac.ks
echo "label KVMonpower-Netboot-Build-install">$netinst
echo "kernel http://${cobrep}/"$lnx_var>>$netinst
echo "initrd http://${cobrep}/"$init_var>>$netinst
#append=`cat /var/www/cobbler/ks_mirror/${iso}-distro-ppc64/etc/yaboot.conf |awk '/append/ {print}'|sed -e 's/ *append = //' -e 's/ADDRESS/\${cobrep}\/LiveOS/' -e 's/REPO//' -e 's/ADDRESS/\${cobrep}\/packages/'|sed -e 's/"//g'|cobrep=$cobrep envsubst`
append=`echo 'ksdevice=bootif lang=  kssendmac text root=live:http://${cobrep}/LiveOS/squashfs.img selinux=0 rd.dm=0 rd.md=0 repo=http://${cobrep}/packages'|cobrep=$cobrep envsubst`
echo "append \"$append \"">>$netinst
#dsk=`echo $kargs|sed -n 's/.*disk=\(.*\).*/\1/p'`
dsk=$kargs
#[[ -z dsk ]] ; dsk='/dev/sda'
[[ -z ${dsk} ]] && dsk='/dev/sda'
gw=`echo ${ip%.*}'.1'`
cat <<EOF >$ksinst
%pre
%end
partition / --ondisk=$dsk
network --device net0 --ip=$ip --netmask=255.255.255.0 --gateway=$gw
timezone America/Chicago
%post
%end
EOF
touch ./env.sh
echo "kernel=http://${cobrep}/"$lnx_var>>./env.sh
echo "initrd=http://${cobrep}/"$init_var>>./env.sh
echo "append=\"$append \"">>./env.sh
echo "ksfile=http://${cobhost}/cobbler/ks_mirror/${mac}.ks">>./env.sh
echo "installdisk=${dsk}">>./env.sh
umount mnt
