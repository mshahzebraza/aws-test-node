FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

# Install curl (for ecs healthchecks )
RUN apk add --no-cache curl

# Add a healthcheck endpoint
HEALTHCHECK \
  --interval=30s \
  --timeout=30s \
  --start-period=5s \
  --retries=3 \
  CMD curl -f localhost:3000/health && echo "Healthcheck passed" || { echo "Healthcheck failed"; exit 1; }

# REVIEW: Remove temporarily to fix the deployment error
ENV MONGODB_URI=mongodb+srv://mshahzebraza97:5CZFuHT3vtjA3JVk@cluster0.21ixo.mongodb.net/testdb?retryWrites=true&w=majority&appName=Cluster0
  
CMD ["npm", "start"] 
