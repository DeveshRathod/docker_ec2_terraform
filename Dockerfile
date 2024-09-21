# Using Node.js 18 Alpine as the base image for the build stage
FROM node:18-alpine as build

# Setting the working directory to /app/client for the client-side application
WORKDIR /app/client

# Copying client package.json and package-lock.json to install dependencies
COPY client/package*.json ./

# Installing client-side dependencies
RUN npm install

# Copying the rest of the client files into the container
COPY client/ ./

# Running the build process for the client-side application
RUN npm run build

# Using Node.js 18 Alpine again as the base image for the final stage
FROM node:18-alpine

# Setting the working directory to /app for the server-side code
WORKDIR /app

# Copying server package.json and package-lock.json to install dependencies
COPY package*.json ./

# Installing server-side dependencies
RUN npm install

# Copying the server-side code into the /app/api directory
COPY api/ ./api

# Copying the built client-side files from the build stage to /app/client/dist
COPY --from=build /app/client/dist ./client/dist

# Exposing port 4000 to access the app
EXPOSE 4000

# Setting the command to run the server when the container starts
CMD ["node", "api/index.js"]


