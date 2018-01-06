ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG OPENJDK_PRODUCT_VERSION
ARG OPENJDK_UPDATE_VERSION
ARG JRE_HOME="/usr/lib/jvm/default-jvm/jre"

ENV \
  OPENJDK_PRODUCT_VERSION="${OPENJDK_PRODUCT_VERSION}" \
  OPENJDK_UPDATE_VERSION="${OPENJDK_UPDATE_VERSION}" \
  JRE_HOME="${JRE_HOME}" \
  PATH="${JRE_HOME}/bin:${PATH}"

RUN set -exo pipefail; \
  apk add --no-cache "openjdk${OPENJDK_PRODUCT_VERSION}-jre-base>${OPENJDK_PRODUCT_VERSION}.${OPENJDK_UPDATE_VERSION}"; \
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

COPY jre/rootfs /
