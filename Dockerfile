# Base image
FROM alpine:3.18

# install required packages
RUN	apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  jq

RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o /bin/minio-binaries/mc

RUN chmod +x /bin/minio-binaries/mc

# Copies entrypoint to file system
COPY entrypoint.sh /entrypoint.sh

# change permission to execute the script
RUN chmod +x /entrypoint.sh

# file to execute when the docker container starts up
ENTRYPOINT ["/entrypoint.sh"]

