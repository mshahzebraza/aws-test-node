FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

# Install curl (for ecs healthchecks )
RUN apk add --no-cache curl

# Add a healthcheck endpoint
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
  
CMD ["npm", "start"] 
