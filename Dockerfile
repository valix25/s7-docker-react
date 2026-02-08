# Specify a base image
FROM node:20-alpine AS builder

WORKDIR /app

# Copy only dependency manifests
COPY package.json ./

# Clean npm state + install
RUN npm cache clean --force \
    && npm install

COPY ./ ./

RUN npm run build


# Serve the app with nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
