#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
IZIN=$( curl https://raw.githubusercontent.com/Annjayy/ssh/main/ipvps | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Please Contact Admin"
rm -f setup.sh
exit 0
fi
if [ -f "/etc/v2ray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
mkdir /var/lib/makhlukvpn-script;
echo "IP=" >> /var/lib/makhlukvpn-script/ipvps.conf
wget https://raw.githubusercontent.com/Annnjayy/ssh/main/cf.sh && chmod +x cf.sh && ./cf.sh
#install ssh ovpn
wget https://raw.githubusercontent.com/Annnjayy/ssh/main/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/sstp.sh && chmod +x sstp.sh && screen -S sstp ./sstp.sh
#install ssr
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/ssr.sh && chmod +x ssr.sh && screen -S ssr ./ssr.sh
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/sodosok.sh && chmod +x sodosok.sh && screen -S ss ./sodosok.sh
#installwg
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh
#install v2ray
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/ins-vt.sh && chmod +x ins-vt.sh && screen -S v2ray ./ins-vt.sh
#install L2TP
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/ipsec.sh && chmod +x ipsec.sh && screen -S ipsec ./ipsec.sh
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/set-br.sh && chmod +x set-br.sh && ./set-br.sh
# Install Neofetch 
#wget https://raw.githubusercontent.com/senowahyu62/freesc/main/geo.sh && chmod +x geo.sh && ./geo.sh && dos2unix /usr/bin/geo.sh
#install edu
wget https://raw.githubusercontent.com/Annnjayy/ssh/main/websocket.sh && chmod +x websocket.sh && ./websocket.sh
wget https://raw.githubusercontent.com/Annnjayy/ssh/main/ssh-ws.sh && chmod +x ssh-ws.sh && screen -S ssh-ws ./ssh-ws.sh

rm -f /root/ssh-vpn.sh
#rm -f /root/sstp.sh
#rm -f /root/wg.sh
#rm -f /root/ss.sh
#rm -f /root/ssr.sh
#rm -f /root/ins-vt.sh
#rm -f /root/ipsec.sh
#rm -f /root/set-br.sh
#rm -f /root/geo.sh
rm -f /root/websocket.sh
rm -f /root/ssh-ws.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://geoganteng.tech

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://raw.githubusercontent.com/Annnjayy/ssh/main/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver
clear
echo " "
echo "Installation has been completed!!"
echo " "
echo "============ {Service & Port} =============" | tee -a log-install.txt
echo ""
echo "   - OpenSSH                : 22"  | tee -a log-install.txt
echo "   - OpenVPN                : TCP 1194, UDP 2200, SSL 442"  | tee -a log-install.txt
echo "   - Stunnel4                : 222, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - SSH Websocket TLS      : 443"  | tee -a log-install.txt
echo "   - SSH Websocket NonTLS   : 80"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS        : 8443"  | tee -a log-install.txt
echo "   - V2RAY Vmess NonTLS    : 80"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - V2RAY Vless NonTLS    : 8880"  | tee -a log-install.txt
echo "   - Trojan                  : 2087"  | tee -a log-install.txt
echo ""
echo "======= {Server Information & Other Features} ======="  | tee -a log-install.txt
echo ""
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                 : [ON]"  | tee -a log-install.txt
echo "   - Dflate                   : [ON]"  | tee -a log-install.txt
echo "   - IPtables                 : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo "   - Dev/Main                : MakhlukVpn"  | tee -a log-install.txt
echo "   - Telegram                 : t.me/MakhlukVpn"  | tee -a log-install.txt
#echo "   - Instagram               : @senowahyu62"  | tee -a log-install.txt
#echo "   - Whatsapp                : 082220155143"  | tee -a log-install.txt
#echo "   - Facebook                : https://www.facebook.com/senowahyu62" | tee -a log-install.txt
echo ""
echo "========= {Script Created By MakhlukVpn} ========" | tee -a log-install.txt
echo ""
echo " Reboot 10 Sec"
sleep 10
rm -f setup.sh
reboot

