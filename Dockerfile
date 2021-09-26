FROM amazonlinux:latest

# apache
RUN yum update -y \
    && yum -y install httpd procps wget tar systemd-sysv git

# mariadb
RUN yum update -y \
    && yum -y install mariadb mariadb-server procps systemd-sysv

# php関連
RUN amazon-linux-extras enable php7.3
RUN yum install php php-gd php-mysqlnd php-xmlrpc -y

# 自動起動
RUN systemctl enable httpd.service
RUN systemctl enable mariadb

# 権限変更
RUN chown -R apache:apache /var/www/html
RUN chown -R mysql:mysql /var/lib/mysql

# ポート80開放
EXPOSE 80
EXPOSE 3306

# コンテナ起動時に各種プロセス起動
CMD ["/sbin/init"]
