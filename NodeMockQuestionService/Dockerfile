# Use the official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Environment variable for Google API key (can override at runtime)
ENV GOOGLE_API_KEY=AIzaSyChpPCR3wY7lmnPFAoX28g8I_ELgk6h7TI

# Expose the port the app runs on
EXPOSE 3001

# Command to run the application
CMD ["node", "index.js"]