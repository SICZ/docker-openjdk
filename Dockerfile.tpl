FROM sicz/baseimage-centos:%%BASE_IMAGE_TAG%%

ENV org.label-schema.schema-version="1.0"
ENV org.label-schema.name="%%DOCKER_PROJECT%%/%%DOCKER_NAME%%"
ENV org.label-schema.description="%%DOCKER_DESCRIPTION%%"
ENV org.label-schema.build-date="%%REFRESHED_AT%%"
ENV org.label-schema.url="http://openjdk.java.net"
ENV org.label-schema.vcs-url="https://github.com/%%DOCKER_PROJECT%%/docker-%%DOCKER_NAME%%"

ENV JAVA_HOME=/usr/lib/jvm/jre
ARG JRE_HOME=${JAVA_HOME}
ENV PATH=${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin

RUN set -ex \
  && yum install -y java-1.%%OPENJDK_MAJOR_VERSION%%.0-openjdk-headless \
  && yum clean all \
  && ${JAVA_HOME}/bin/java -version \
  ;

RUN set -ex \
  # Install development dependencies
  && yum history new \
  || yum history new \
  && yum install -y unzip \
  # Install Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy
  # https://github.com/floragunncom/search-guard-ssl/issues/43
  && curl -jksSLOH "Cookie: oraclelicense=accept-securebackup-cookie" \
      "http://download.oracle.com/otn-pub/java/jce/%%OPENJDK_MAJOR_VERSION%%/jce_policy-%%OPENJDK_MAJOR_VERSION%%.zip" \
  && unzip -jo -d ${JRE_HOME}/lib/security jce_policy-%%OPENJDK_MAJOR_VERSION%%.zip \*/\*.jar \
  && chmod g-w ${JRE_HOME}/lib/security/*.jar \
  && rm -f jce_policy-%%OPENJDK_MAJOR_VERSION%%.zip \
  # Speed up Java with non-blocking /dev/urandom instead of blocking /dev/random
  # https://docs.oracle.com/cd/E13209_01/wlcp/wlss30/configwlss/jvmrand.html
  && sed -i \
      -e 's;securerandom.source=file:/dev/random;securerandom.source=file:/dev/urandom;' \
      -e 's;securerandom.strongAlgorithms=NativePRNGBlocking;securerandom.strongAlgorithms=NativePRNGNonBlocking;' \
      ${JRE_HOME}/lib/security/java.security \
  # Set DNS caching to 30s
  # https://github.com/floragunncom/search-guard-ssl/issues/43
  && sed -i \
      -e 's;#networkaddress.cache.ttl=-1;networkaddress.cache.ttl=30;' \
      ${JRE_HOME}/lib/security/java.security \
  # Uninstall development dependencies
  && yum history -y undo 1 \
  # Cleanup yum
  && yum clean all \
  ;

COPY docker-entrypoint.d /docker-entrypoint.d
