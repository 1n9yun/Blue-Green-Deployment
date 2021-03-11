# Dockefile for Nginx

FROM nginx

COPY ./nginx.conf /etc/nginx/

VOLUME /var/log/nginx/log
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
