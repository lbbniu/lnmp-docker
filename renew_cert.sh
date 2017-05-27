#!/usr/bin/env bash

#0 0 1 * * /data/www/ssl/renew_cert.sh >/dev/null 2>&1


DOMAIN=www.lbbniu.com
ACCOUNT=lbbniu
cd /data/www/ssl
python acme_tiny.py --account-key $ACCOUNT.key --csr $DOMAIN.csr --acme-dir /data/www/ssl/web > $DOMAIN.crt || exit
wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > intermediate.pem

cat $DOMAIN.crt intermediate.pem > chained.pem
docker exec nginx_min nginx -t
docker exec nginx_min nginx -s reload