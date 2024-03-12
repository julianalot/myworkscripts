#!/bin/bash
# -------------------------------------------
# /etc/letsencrypt/certbot-renew.bash
# -------------------------------------------
echo -----------------------------
echo Renewing *.hq.takealot.com
echo -----------------------------

/usr/bin/certbot certonly \
    --manual \
    --preferred-challenges=dns \
    --email first.last@domain.com \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --agree-tos \
    -d '*.hq.takealot.com'

read -rsp $'Press any key to continue...\n' -n1 key

echo -----------------------------
echo Renewing *.cwh.takealot.com
echo -----------------------------

/usr/bin/certbot certonly \
    --manual \
    --preferred-challenges=dns \
    --email first.last@domain.com \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --agree-tos \
    -d '*.cwh.takealot.com'

read -rsp $'Press any key to continue...\n' -n1 key

echo -----------------------------
echo Renewing *.jwh.takealot.com
echo -----------------------------

/usr/bin/certbot certonly \
    --manual \
    --preferred-challenges=dns \
    --email first.last@domain.com \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --agree-tos \
    -d '*.jwh.takealot.com'

read -rsp $'Press any key to continue...\n' -n1 key

echo -----------------------------
echo Renewing *.net.takealot.com
echo -----------------------------

/usr/bin/certbot certonly \
    --manual \
    --preferred-challenges=dns \
    --email first.last@domain.com \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --agree-tos \
    -d '*.net.takealot.com'
