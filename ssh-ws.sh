#!/bin/bash
# Proxy For Ssh & Ovpn Websocket
# ====================================
echo Installing Websocket-SSH Python
sleep 1
echo Cek Hak Akses...
sleep 0.5
# Getting Proxy Template
cd /usr/local/bin/
wget -q -O /usr/local/bin/ssh-ws https://raw.githubusercontent.com/Annnjayy/ssh/main/ssh-ws.py
chmod +x /usr/local/bin/ssh-ws

# Installing Service
cat > /etc/systemd/system/sshws-nontls.service << END
[Unit]
Description=Ssh Websocket By MakhlukVpn
Documentation=https://t.me/MakhlukVpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ssh-ws 80
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable sshws-nontls
systemctl restart sshws-nontls

# Installing Service
cat > /etc/systemd/system/sshws-tls.service << END
[Unit]
Description=Ssh Websocket MakhlukVpn
Documentation=https://t.me/MakhlukVpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ssh-ws 1945
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable sshws-tls
systemctl restart sshws-tls

# Ovpn Websocket !!!
# =================================

# Getting Ovpn Ws Template
wget -q -O /usr/local/bin/ws-ovpn https://raw.githubusercontent.com/Annnjay/ssh/main/ws-ovpn.py
chmod +x /usr/local/bin/ws-ovpn.py


# Installing Service Ovpn Websocket
cat > /etc/systemd/system/ws-ovpn.service << END
[Unit]
Description=Ovpn Websocket By MakhlukVpn
Documentation=https://t.me/MakhlukVpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-ovpn 2082
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-ovpn
systemctl restart ws-ovpn

clear
echo -e "==============================="
echo -e "  Done Install Ssh & Ovpn Websocket  "
echo -e "==============================="
echo -e "PORT SSH NONTLS : 80"
echo -e "PORT SSH TLS    : 443"
echo -e "PORT OVPN WS B  : 2082"
echo -e "==============================="
echo -e "        Script By MakhlukVpn          "
echo -e "==============================="
