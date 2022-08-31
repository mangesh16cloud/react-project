FROM nginx:latest

# set the working dir for container
WORKDIR /frontend

# copy the json file first
COPY ./package.json /frontend

# install npm dependencies
 RUN npm install

# copy other project files
COPY . .

CMD [ "npm", "run", "start" ]
