FROM node:latest as build
# defining default workdir
WORKDIR /app

COPY package*.json ./app

RUN npm install

copy . .

RUN npm run build

# Use the official Nginx image as base
FROM nginx:latest

# Copy the static files from the build directory to Nginx's web root directory
COPY --from=build /app/build/ /usr/share/nginx/html

COPY default.conf /etc/nginx/conf.d 

# Expose port 80 to allow external access to your Nginx server
EXPOSE 80

# Command to start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
