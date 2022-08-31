FROM nginx:latest

LABEL maintainer="mangesh"

COPY ./build /usr/share/nginx/html

EXPOSE 3000

CMD ["build", "run"]
