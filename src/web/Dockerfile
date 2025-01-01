# Dockerfile for node web 

# Use the official image as a parent image
FROM node:lts-bullseye AS build

# Set the working directory
WORKDIR /app

# Copy the file from your host to your current location
COPY package*.json /app/

# Run the command inside your image filesystem
RUN npm install

# Copy the rest of your app's source code from your host to your image filesystem
COPY ./ /app/

# Add agument to the command
ARG configuration=production

# Run the specified command within the container
RUN npm run build -- --output-path=./dist --configuration $configuration

# nginx stage
FROM nginxinc/nginx-unprivileged:stable-bullseye-perl AS host

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/dist/browser /usr/share/nginx/html
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf


