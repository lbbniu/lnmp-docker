#!/bin/bash


#检测配置
docker-compose exec vming nginx -t
docker-compose exec vming nginx -s  reload
docker-compose exec php7 kill -USR2  1




