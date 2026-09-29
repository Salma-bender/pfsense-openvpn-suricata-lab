# Architecture d'entreprise sécurisée : pfSense, OpenVPN & Suricata

Projet de Sécurité des Systèmes et Réseaux, FSTM Marrakech, Université Cadi Ayyad (2025-2026).

## Objectif
Concevoir et sécuriser une architecture d'entreprise virtualisée (VirtualBox) : accès distant par VPN,
serveur interne durci, détection/prévention d'intrusions et filtrage, puis validation par des attaques simulées.

## Architecture

| Machine | Rôle |
|---|---|
| pfSense CE 2.8.1 | Firewall, serveur OpenVPN, Suricata IDS/IPS |
| Ubuntu Server 24.04 | Serveur interne (Apache2, SSH) |
| Windows | Client VPN distant |
| Kali Linux | Machine attaquante |

Réseaux : WAN en Bridged, LAN interne `192.168.56.0/24` en Host-Only, tunnel VPN `10.8.0.0/24`.

## Ce qui a été réalisé
- **VPN OpenVPN** client-to-site (UDP 1194, PKI interne, certificat + identifiants)
- **Durcissement Ubuntu** : UFW deny-by-default, sysctl, PAM (expiration, complexité, faillock), SSH, GRUB, verrouillage root
- **Suricata en inline IPS** sur le WAN : règles Emerging Threats Open + 4 règles personnalisées
- **Attaques simulées** : Nmap (-sS, -sV), ping flood, brute force SSH (Hydra)
- **Firewalling** : SSH/HTTP uniquement via VPN, blocage ICMP sur le WAN, isolation de la machine attaquante

## Résultats

| Attaque | Outil | Règle (SID) | Statut |
|---|---|---|---|
| Scan SYN | Nmap -sS | 9000001 | Détecté |
| Détection de services | Nmap -sV | 9000004 | Détecté |
| Ping flood | ping -f | 2100366 | Détecté |
| Brute force SSH | Hydra | 9000002 | Détecté |

## Contenu du dépôt
- [`docs/rapport-complet.pdf`](docs/rapport-complet.pdf) : rapport complet avec captures
- [`configs/suricata/custom.rules`](configs/suricata/custom.rules) : règles de détection personnalisées
- [`configs/ubuntu/`](configs/ubuntu/) : durcissement (sysctl, UFW, SSH, PAM)

## Limites et pistes d'amélioration
- SIEM (Wazuh / ELK) pour centraliser les logs
- MFA sur le VPN
- Réponse automatisée aux incidents (blocage dynamique)

## Avertissement
Projet pédagogique réalisé dans un environnement virtuel isolé. Les attaques ont été menées uniquement sur mes propres machines virtuelles. Le mot de passe par défaut de pfSense a été conservé car le labo est isolé.

## Auteure
Salma Bender, étudiante ingénieure en cybersécurité (FSTM Marrakech).
