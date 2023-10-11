FROM node:18-alpine

RUN npm install -g @mockoon/cli@5.0.0
COPY ./api.json ./api.json

# Install curl for healthcheck and tzdata for timezone support.
RUN apk --no-cache add curl tzdata

# Do not run as root.
RUN adduser --shell /bin/sh --disabled-password --gecos "" mockoon
RUN chown -R mockoon ./api.json
USER mockoon

EXPOSE 8080

ENTRYPOINT ["mockoon-cli","start","--disable-log-to-file","--data","./api.json","--port","8080"]

# Usage: docker run -p <host_port>:<container_port> mockoon-test