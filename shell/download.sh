#!/bin/bash
case $1 in
	1)
		#X86
		url='http://mirrors.geekfan.top/frp/frp_0.9.3_linux_386.tar.gz'
	;;
	2)
		#X64
		url='http://mirrors.geekfan.top/frp/frp_0.9.3_linux_amd64.tar.gz'
	;;
	3)
		#ARM
		url='http://mirrors.geekfan.top/frp/frp_0.9.3_linux_arm.tar.gz'
	;;
	4)
		#MIPS
		url='http://mirrors.geekfan.top/frp/frp_0.9.3_linux_mips.tar.gz'
	;;
	5)
		#MIPS64
		url='http://mirrors.geekfan.top/frp/frp_0.9.3_linux_mips64.tar.gz'
	;;
	6)
		#MIPSLE
		url='http://mirrors.geekfan.top/frp/frp_0.9.3_linux_mipsle.tar.gz'
	;;
	7)
		#MIPS64LE
		url='http://mirrors.geekfan.top/frp/frp_0.9.3_linux_mips64le.tar.gz'
	;;
esac
rm -rf /etc/frp >/dev/null 2>&1  
mkdir /etc/frp
wget -O /etc/frp/frp.tar.gz $url
