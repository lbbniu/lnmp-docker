#!/bin/bash

#创建目录
mkdir -p  /data/php7session /data/www /data/logs /data/mysql/data

chown -R www:www /data/php7session

#拷贝配置文件
cp -rf config/* /data/

#构建docker
docker-compose up -d
