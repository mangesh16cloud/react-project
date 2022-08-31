# Set the base image.
FROM node:14

COPY ./build /usr/share/nginx/html
COPY ./package.json /usr/share/nginx/html
COPY package-lock.json /usr/share/nginx/html

# copy other project files
COPY . . 

RUN npm install


CMD [ "npm", "run", "start" ]
