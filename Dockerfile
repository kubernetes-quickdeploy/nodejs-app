FROM node:16

WORKDIR /app

# Copy package files first (optimizes Docker cache)
COPY package*.json ./

# Install dependencies
RUN npm install

# Then copy the rest of your app's code
COPY . .

# Expose the desired port
EXPOSE 3000

# Default command to run the app
CMD ["npm", "start"]
