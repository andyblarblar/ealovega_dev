FROM node

WORKDIR /app

COPY src src
COPY public public
COPY package.json package.json
COPY package-lock.json package-lock.json

RUN yarn install
RUN npm run build

FROM nginx

RUN rm /usr/share/nginx/html/*
COPY --from=0 /app/dist /usr/share/nginx/html
EXPOSE 8080