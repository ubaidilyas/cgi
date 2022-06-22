FROM docker.io/nginx:1-alpine
COPY ./nginx_cp_docker/conf /etc/nginx
COPY ./nginx_cp_docker/certs/cgi.crt /etc/ssl/certs
COPY ./nginx_cp_docker/certs/cgi.key /etc/ssl/private/
