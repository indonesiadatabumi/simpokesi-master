FROM nginx:1.18

ADD ./vhost.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www/si-mpo-kesi
