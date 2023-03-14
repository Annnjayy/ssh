#!/bin/bash
clear
echo Installing Websocket-Stunnel Python
sleep 1
echo Cek Hak Akses...
sleep 0.5
cd /usr/local/bin/
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/Annnjayy/ssh/main/ssh-ws-stunnel.py
chmod +x /usr/local/bin/ws-stunnel.py

# Installing Service
cat > /etc/systemd/system/ws-stunnel.service << END
[Unit]
Description=Python Ws Proxy MakhlukVpn
Documentation=https://joysmart.xyz
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-stunnel
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
#Enable & Start & Restart ws-stunnel service
systemctl enable ws-stunnel.service
systemctl restart ws-stunnel.service
