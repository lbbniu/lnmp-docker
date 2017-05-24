## 部署安装过程简单说明
### 1.安装yum-utils
```
yum install -y yum-utils
```
### 2.增加docker-ce版本库
```
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```
### 3.启动版本库
```
 yum-config-manager --enable docker-ce-stable
```
### 4.查看版本
```
yum list docker-ce.x86_64  --showduplicates |sort -r
```
### 5.安装docker
```
yum install -y docker-ce-17.03.1.ce-1.el7.centos
```
### 6.启动和开启启动
```
systemctl start docker
systemctl enable docker.service
```
### 7.添加用户
```
useradd www
```
### 8.安装git
```
yum install -y git
```
### 9.安装docker-compose
```
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
docker镜像加速
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://45bf300f.m.daocloud.io
systemctl restart docker
```
### 10.创建目录
```
mkdir -p /data/www
```
### 11.拉去代码
```
cd /data/www
git clone https://github.com/lbbniu/lbbniu.git
```
### 12.部署
```
cd /data/www/lbbniu
创建静态资料存放路径
mkdir -p public/image
chown -R www:www storage bootstrap public/image  public/img 
cd /data/www/lbbniu/deploy
./deploy.sh
docker exec -ti php7_min sh
composer install --no-dev
php artisan key:generate
修改.env 配置文件(修改数据库配置，队列，缓存配置)
php artisan passport:keys
导入数据库结构
php artisan migrate:refresh
导入初始化数据
php artisan db:seed
添加定时任务
* * * * *  docker exec php7_min  php /data/www/lbbniu/artisan schedule:run >> /dev/null 2>&1
```