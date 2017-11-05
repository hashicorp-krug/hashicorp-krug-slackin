#
# SLACK INVITE WEB
#
# build:
#   docker build --force-rm -t hashicorpkrug/slack-invite-web .
# run:
#   docker run --env-file=path/to/.env --name slack-invite-web -d -p 80:5555 -it hashicorpkrug/slcak-invite-web
#

### RELEASE
FROM node:8.9-alpine
# Install slackin
RUN npm install --global slackin
# Expose application port
EXPOSE 3000
# Run
CMD slackin -p 3000 $SLACK_ORG
