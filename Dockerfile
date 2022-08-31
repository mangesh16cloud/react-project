# Set the base image.
FROM node:14

#copy all files from server to conatiner
COPY ./build /usr/share/nginx/html
COPY ./package.json /usr/share/nginx/html
COPY package-lock.json /usr/share/nginx/html

# copy other project files
COPY . . 

# install npm package inside container
RUN npm install

#install pm2 service for make npm demon process 
RUN npm install pm2 -g
RUN pm2 start npm -- start

CMD [ "npm", "run", "start" ]
