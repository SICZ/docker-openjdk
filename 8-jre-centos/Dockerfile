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

ARG OPENJDK_PRODUCT_VERSION
ARG OPENJDK_UPDATE_VERSION

ENV JRE_HOME=/usr/lib/jvm/jre
ENV PATH="${JRE_HOME}/bin:${PATH}"

RUN set -exo pipefail; \
  yum install -y "java-1.${OPENJDK_PRODUCT_VERSION}.0-openjdk-headless-1:1.${OPENJDK_PRODUCT_VERSION}.0.${OPENJDK_UPDATE_VERSION}-*"; \
  yum clean all; \
  java -version; \
  # Speed up Java with non-blocking /dev/urandom instead of blocking /dev/random
  # https://docs.oracle.com/cd/E13209_01/wlcp/wlss30/configwlss/jvmrand.html
  sed -i \
    -e 's;securerandom.source=file:/dev/random;securerandom.source=file:/dev/urandom;' \
    -e 's;securerandom.strongAlgorithms=NativePRNGBlocking;securerandom.strongAlgorithms=NativePRNGNonBlocking;' \
    ${JRE_HOME}/lib/security/java.security; \
  # Set Java DNS caching to 10s
  # https://github.com/floragunncom/search-guard-ssl/issues/43
  sed -i \
    -e 's;#networkaddress.cache.ttl=-1;networkaddress.cache.ttl=10;' \
    ${JRE_HOME}/lib/security/java.security

COPY config /
