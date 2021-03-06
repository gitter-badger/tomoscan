FROM node:8-slim
WORKDIR /var/www/
# Expose env host
# This is needed to ensure communication between containers
# between docker containers
ENV HOST 0.0.0.0

COPY server/package.json /var/www/package.json

RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  apt-get install -y git nano && \
  rm -rf /var/lib/apt/lists/*

RUN npm i npm@latest -g
RUN npm install
RUN npm install -g dotenv node-gyp pm2

COPY server/.env.example /var/www/.env
COPY server /var/www
COPY server/pm2.json /var/www/pm2.json

CMD npm run dev

EXPOSE 3333