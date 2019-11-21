FROM maven:3-alpine
RUN apk update && \
    apk upgrade && \
    apk add bash && \
    apk add --update \
    python \
    python-dev \
    py-pip \
    build-base && \
    apk add --no-cache --virtual build-deps build-base gcc && \
    pip install aws-sam-cli
