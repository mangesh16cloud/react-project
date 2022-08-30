FROM nginx:latest

LABEL maintainer="mangesh"

COPY ./workspace/react/build /usr/share/nginx/html

EXPOSE 8080

CMD ["catalina.sh", "run"]
