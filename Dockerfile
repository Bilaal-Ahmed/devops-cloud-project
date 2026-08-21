FROM nginx:alpine
COPY portfolio/ /usr/share/nginx/html/
EXPOSE 80
