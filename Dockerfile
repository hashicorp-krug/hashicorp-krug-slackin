#
# HASHICORP KRUG SLACKIN
#
# build:
#   docker build --force-rm -t hashicorpkrug/slackin .
# run:
#   docker run --env-file=path/to/.env --name hashicorp-krug-slackin -d -p 80:5555 -it hashicorpkrug/slackin
#
#

### BASE
FROM node:8.8.1-alpine AS base
# Set the working directory
WORKDIR /app
# Copy project specification and dependencies lock files
COPY package.json yarn.lock ./
# Install yarn
RUN apk --no-cache add yarn


### DEPENDENCIES
FROM base AS dependencies
# Install Node.js dependencies (only production)
RUN yarn --production
# Copy production dependencies aside
RUN cp -R node_modules /tmp/node_modules
# Install ALL Node.js dependencies
RUN yarn


### TEST
FROM dependencies AS test
# Copy app sources
COPY . .
# Run linters
RUN yarn lint


### RELEASE
FROM base AS release
# Copy production dependencies
COPY --from=dependencies /tmp/node_modules ./node_modules
# Copy app sources
COPY . .
# Expose application port
EXPOSE 5555
# Run
CMD ["yarn", "run", "pm2-docker", "--", "--env", "production", "process.json"]
