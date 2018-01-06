ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG JAVA_HOME="/usr/lib/jvm/default-jvm"

ENV \
  JAVA_HOME="${JAVA_HOME}" \
  PATH="${JAVA_HOME}/bin:${PATH}"

RUN set -exo pipefail; \
  apk add --no-cache "openjdk${OPENJDK_PRODUCT_VERSION}>${OPENJDK_PRODUCT_VERSION}.${OPENJDK_UPDATE_VERSION}"; \
  javac -version
