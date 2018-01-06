ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG JAVA_HOME="/usr/lib/jvm/java"

ENV \
  JAVA_HOME="${JAVA_HOME}" \
  PATH="${JAVA_HOME}/bin:${PATH}"

RUN set -exo pipefail; \
  yum install -y "java-1.${OPENJDK_PRODUCT_VERSION}.0-openjdk-devel-1:1.${OPENJDK_PRODUCT_VERSION}.0.${OPENJDK_UPDATE_VERSION}-*"; \
  yum clean all; \
  javac -version
