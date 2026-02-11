# Stage 1: Build the website
FROM node:22-alpine AS build

WORKDIR /website
COPY website/package.json website/package-lock.json ./
RUN npm ci
COPY website/ ./
RUN npm run build

# Stage 2: Fetch docs
FROM alpine/git AS docs

RUN git clone --depth 1 --branch main https://github.com/habitsfactory/habitsfactory-docs.git /tmp/repo

# Stage 3: Serve with nginx
FROM nginx:alpine

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built website files
COPY --from=build /website/dist /usr/share/nginx/html/

# Copy docs site
COPY --from=docs /tmp/repo/site/ /usr/share/nginx/docs/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
