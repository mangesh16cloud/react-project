FROM nginx:latest

LABEL maintainer="mangesh"

COPY ./var/www/workspace/react/build /usr/share/nginx/html

EXPOSE 8080

CMD ["catalina.sh", "run"]
