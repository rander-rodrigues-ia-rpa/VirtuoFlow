FROM nginx:alpine
COPY . /usr/share/nginx/html/
RUN sed -i 's/try_files \$uri \$uri\/ =404;/try_files \$uri \$uri\/ \$uri.html =404;/' /etc/nginx/conf.d/default.conf
EXPOSE 80
