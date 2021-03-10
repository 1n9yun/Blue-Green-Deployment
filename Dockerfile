# Dockefile for Nginx

FROM nginx

COPY ./nginx.conf /etc/nginx/

VOLUME /var/log/nginx/log
EXPOSE 8084
CMD ["nginx", "-g", "daemon off;"]
