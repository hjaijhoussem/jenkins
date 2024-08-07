#Mutli stage Dockerfile
# FROM node:latest as build
# WORKDIR /app
# COPY package*.json ./app
# RUN npm install
# COPY . .
# RUN npm run build

# FROM nginx:latest
# COPY --from=build /app/build/ /usr/share/nginx/html
# COPY default.conf /etc/nginx/conf.d 
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

FROM node:latest AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:latest
COPY --from=build /app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

