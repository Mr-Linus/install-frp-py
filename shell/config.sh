#!/bin/bash
HTTP=$RANDOM 
SSH=$RANDOM
rm -f /etc/frp/frp-config/frpc.ini 
sudo cat > /etc/frp/frp-config/frpc.ini <<EOF
[common]
server_addr = www.funkystars.cn
server_port = 7000
log_file = ./frpc.log
log_level = info
log_max_days = 3
privilege_token = geekfan.top123

[$HTTP]
privilege_mode = true
type = http
local_ip = 127.0.0.1
local_port = 80
custom_domains = www.youname.com

[$SSH]
privilege_mode = true
type = tcp
remote_port = $SSH
local_ip = 127.0.0.1
local_port = 22
use_gzip = true use_encrypti
EOF

sudo cat > /etc/init.d/frp <<EOF
#!/bin/bash
# chkconfig: - 99 2
# description: FRP Client Control Script
green='\e[1;32m' 
red='\e[1;31m' 
nc='\e[0m'
PIDF=\` ps  -A | grep frpc | awk '{print \$1}'\`
PIDK=\` ps  -A | grep keepalived | awk '{print \$1}'\`
case "\$1" in
        start)
		echo -n "FRP 正在启动..."
        nohup /etc/frp/frp-config/frpc -c /etc/frp/frp-config/frpc.ini >/dev/null 2>&1  &
		RE=\$?
		nohup /etc/frp/frp_keepalived >/dev/null 2>&1  &
		if [ \$? -eq 0 -o \$RE -eq 0 ] 2> /dev/null ; then
				sleep 1
				echo -e "[\${green}成功\${nc}]"
		else 
				echo -e "[\${red}失败\${nc}]"
		fi
        ;;
        stop)
		echo -n "FRP 正在停止..."
        kill -9 \$PIDF
		RE=\$?
		kill -9  \$PIDK
		if [ \$? -eq 0 -o \$RE -eq 0 ] 2> /dev/null ; then
				sleep 1
				echo -e "[\${green}成功\${nc}]"
		else 
				echo -e "[\${red}失败\${nc}]"
		fi		
        ;;
        restart)
        \$0 stop &> /dev/null
        if [ \$? -ne 0 ] 2> /dev/null ; then continue ; fi
        \$0 start
        ;;
        reload)
		echo -n "FRP 正在平滑重启..."
        kill -1 \$PIDF
		RE=\$?
		kill -1 \$PIDK
		if [ \$? -eq 0 -o \$RE -eq 0 ] 2> /dev/null ; then
				sleep 1
				echo -e "[\${green}成功\${nc}]"
		else 
				echo -e "[\${red}失败\${nc}]"
		fi
        ;;
		status)
		echo "FRP 当前状态:"
		cat /frpc.log
		;;
        *)
        echo "Userage: \$0 { start | stop | restart | reload | status }"
        exit 1
esac
exit 0

EOF

chmod +x /etc/init.d/frp
