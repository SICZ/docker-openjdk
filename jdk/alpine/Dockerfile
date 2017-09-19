ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG DOCKER_IMAGE_NAME
ARG DOCKER_IMAGE_TAG
ARG DOCKER_PROJECT_DESC
ARG DOCKER_PROJECT_URL
ARG BUILD_DATE
ARG GITHUB_URL
ARG VCS_REF

LABEL \
  org.label-schema.schema-version="1.0" \
  org.label-schema.name="${DOCKER_IMAGE_NAME}" \
  org.label-schema.version="${DOCKER_IMAGE_TAG}" \
  org.label-schema.description="${DOCKER_PROJECT_DESC}" \
  org.label-schema.url="${DOCKER_PROJECT_URL}" \
  org.label-schema.vcs-url="${GITHUB_URL}" \
  org.label-schema.vcs-ref="${VCS_REF}" \
  org.label-schema.build-date="${BUILD_DATE}"

ARG JAVA_HOME="/usr/lib/jvm/default-jvm"

ENV \
  JAVA_HOME="${JAVA_HOME}" \
  PATH="${JAVA_HOME}/bin:${PATH}"

RUN set -exo pipefail; \
  apk add --no-cache "openjdk${OPENJDK_PRODUCT_VERSION}>${OPENJDK_PRODUCT_VERSION}.${OPENJDK_UPDATE_VERSION}"; \
  javac -version
