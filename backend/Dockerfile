# Use official Node.js 18 image
FROM node:18

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if exists)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all app files
COPY . .

# Expose the port your app runs on
EXPOSE 8800

# Start the server
CMD ["node", "index.js"]
