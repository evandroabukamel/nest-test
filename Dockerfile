FROM node:12.16 as builder

WORKDIR /opt/build

COPY . .

# installs npm packages
RUN npm install
RUN npm audit fix
# builds the aplication
RUN npm run build
# cleans the build
RUN npm prune --production
# Creates and changes to app folder

WORKDIR /opt/app

# moves the application builded to app folder
RUN mv /opt/build/node_modules ./node_modules
RUN mv /opt/build/dist ./dist
RUN mv /opt/build/package.json ./package.json

FROM node:12.16-alpine as release

WORKDIR /opt/app

COPY --from=builder /opt/app .

EXPOSE 3000

CMD [ "npm", "run", "start" ]
