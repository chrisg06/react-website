FROM node as build

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=build-stage /urs/app/build .

ENTRYPOINT ["nginx", "-g", "daemon off;"]
