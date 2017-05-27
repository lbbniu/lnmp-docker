#!/usr/bin/env bash
#Let's Encrypt
#https://imququ.com/post/letsencrypt-certificate.html
#https://imququ.com/post/my-nginx-conf.html

DOMAIN=www.lbbniu.com
ACCOUNT=lbbniu
#创建帐号
openssl genrsa 4096 > $ACCOUNT.key

#创建 CSR 文件
openssl genrsa 4096 > $DOMAIN.key

openssl req -new -sha256 -key $DOMAIN.key -subj "/" -reqexts SAN -config <(cat /etc/pki/tls/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:$DOMAIN")) > $DOMAIN.csr

#使用交互方式创建 CSR（需要注意 Common Name 必须为你的域名）：
#openssl req -new -sha256 -key domain.key -out domain.csr

wget https://raw.githubusercontent.com/diafygi/acme-tiny/master/acme_tiny.py

python acme_tiny.py --account-key ./$ACCOUNT.key --csr ./$DOMAIN.csr --acme-dir /data/www/ssl/web > ./$DOMAIN.crt

wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > intermediate.pem
cat $DOMAIN.crt intermediate.pem >> chained.pem

wget -O - https://letsencrypt.org/certs/isrgrootx1.pem > root.pem
cat intermediate.pem root.pem >> full_chained.pem