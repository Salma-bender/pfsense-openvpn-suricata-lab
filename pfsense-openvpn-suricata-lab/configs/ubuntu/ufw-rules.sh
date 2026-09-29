#!/bin/bash
# Pare-feu UFW : deny by default, SSH et HTTP uniquement depuis le VPN et le LAN
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow from 10.8.0.0/24 to any port 22 proto tcp comment "SSH via VPN"
sudo ufw allow from 10.8.0.0/24 to any port 80 proto tcp comment "HTTP via VPN"
sudo ufw allow from 192.168.56.0/24 to any port 22 proto tcp comment "SSH via LAN"
sudo ufw allow from 192.168.56.0/24 to any port 80 proto tcp comment "HTTP via LAN"

sudo ufw enable
sudo ufw status numbered
