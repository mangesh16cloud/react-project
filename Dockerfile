FROM nginx:latest

LABEL maintainer="mangesh"

COPY ./build /usr/share/nginx/html

EXPOSE 3001

CMD ["catalina.sh", "run"]
