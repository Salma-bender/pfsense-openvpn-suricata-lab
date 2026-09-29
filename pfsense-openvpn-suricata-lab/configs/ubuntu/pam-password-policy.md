# Politique de mots de passe (PAM)

## Expiration : /etc/login.defs
```
PASS_MAX_DAYS   90
PASS_MIN_DAYS   7
PASS_WARN_AGE   14
```

## Complexité : /etc/security/pwquality.conf
```
minlen = 12
dcredit = -1
ucredit = -1
lcredit = -1
ocredit = -1
minclass = 3
maxrepeat = 3
```

## Verrouillage après échecs
Dans `/etc/pam.d/common-auth` :
```
auth required pam_faillock.so preauth silent deny=5 unlock_time=900
```
Dans `/etc/pam.d/common-account` :
```
account required pam_faillock.so
```
