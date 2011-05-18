#!/bin/bash
#set -x

arch=`uname -m`
fedora_release=`cat /etc/fedora-release | cut -d " " -f3`

device_id=`/sbin/lspci | grep -i vga`
is_geforce=`echo $device_id | egrep -i '(vga).*(geforce)'`
geforce_96xx=`echo $device_id | egrep -i '(vga).*(geforce).([2-4])'`
geforce_173xx=`echo $device_id | egrep -i '(vga).*(geforce fx)'`



pae_check=`uname -r | grep PAE`



repo_setup() {


su -c 'wget http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm \
		http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm' || exit;

su -c 'yum -y --nogpgcheck shell <<EOF
localinstall ./rpmfusion-free-release-stable.noarch.rpm
localinstall ./rpmfusion-nonfree-release-stable.noarch.rpm
run
quit
EOF'

	if [ "$?" != "0" ]; then
		exit;
	fi

	yum info kmod-nvidia > /dev/null 2>&1
	RET=$?
	
	if [ $RET == 1 ]; then
  		
		echo "yum info kmod-nvidia failed! Your repo is not setup properly!"
  	exit 1
fi


}


install_standard() {


	if [ -z "$pae_check" ]; then
		su -c 'yum -y install kmod-nvidia';
	else
		su -c 'yum -y install kmod-nvidia-PAE';
	fi

}


install_old_5() {

	if [ -z "$pae_check" ] && [ ! -z "$geforce_173xx" ]; then
		su -c 'yum -y install kmod-nvidia-173xx';
	else
		su -c 'yum -y install kmod-nvidia-173xx-PAE';
	fi
}


install_old_24() {

	if [ -z "$pae_check" ] && [ ! -z "$geforce_96xx" ]; then
	
		su -c 'yum -y install nvidia-kmod-96xx';
	else
		su -c 'yum -y install nvidia-kmod-96xx-PAE';
	fi
}


if [ ! -z "$is_geforce" ]; then
	repo_setup
fi


if [ -z "$is_geforce" ]; then

	echo "You may not be using an nVidia card.";
	exit;

elif [ ! -z "$is_geforce" ] && [ ! -z "$geforce_173xx" ]; then
	
	install_old_5
elif [ ! -z "$is_geforce" ] && [ ! -z "$geforce_96xx" ]; then

	install_old_24
else	
	install_standard
fi

# Check if SELinux is enabled.
selinux=`/usr/sbin/getenforce | egrep '(Enforcing|Permissive)'`

if [ ! -z "$selinux" ]; then
   su -c 'setsebool -P allow_execstack on';
fi

if [ -f /boot/initramfs-$(uname -r).img ]; then
    su -c 'mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img';
fi


# Pull a list of versions from kmod-nvidia packages use $pae_check
if [ ! -z $pae_check ]; then
    for package in kmod-nvidia-PAE kmod-nvidia-173xx-PAE kmod-nvidia-96xx-PAE; do
        rpm -q $package && nvidia_package=$(rpm -q --qf "%{name}\n" $package)
    done

        for kernel_version in $(rpm -q --qf "%{version}-%{release}.%{arch}\n" 'kernel-PAE'); do
            to_rebuild=$(rpm -q $nvidia_package-$kernel_version-$(rpm -q --qf "%{version}\n" $nvidia_package))
            if [[ $? != 1 && ! -z $to_rebuild ]]; then
                su -c "dracut --force /boot/initramfs-$kernel_version.img $kernel_version";
            fi
        done
else
    for package in kmod-nvidia kmod-nvidia-173xx kmod-nvidia-96xx; do
        rpm -q $package && nvidia_package=$(rpm -q --qf "%{name}\n" $package)
    done

        for kernel_version in $(rpm -q --qf "%{version}-%{release}.%{arch}\n" 'kernel'); do
            to_rebuild=$(rpm -q $nvidia_package-$kernel_version-$(rpm -q --qf "%{version}\n" $nvidia_package))
            if [[ $? != 1 && ! -z $to_rebuild ]]; then
                su -c "dracut --force /boot/initramfs-$kernel_version.img $kernel_version";
            fi
        done
fi
    


echo -e "\n\n"
echo "Well if this script gets this far, it looks like you just installed nVidia drivers.";
echo "Reboot the system using: reboot or shutdown now -r ";

exit;
