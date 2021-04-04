FROM node:12.16-alpine

WORKDIR /opt/app

COPY . .

# installs npm packages
RUN npm install
RUN npm audit fix
# builds the aplication
RUN npm run build
# cleans the build
RUN npm prune --production

EXPOSE 3000

CMD [ "npm", "run", "start:prod" ]
