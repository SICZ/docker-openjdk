FROM sicz/baseimage-alpine:3.5

ENV \
  org.label-schema.schema-version="1.0" \
  org.label-schema.name="sicz/openjdk" \
  org.label-schema.description="An OpenJDK image based on Alpine Linux." \
  org.label-schema.build-date="2017-04-19T22:10:48Z" \
  org.label-schema.url="http://openjdk.java.net" \
  org.label-schema.vcs-url="https://github.com/sicz/docker-openjdk"

RUN set -x && apk add --no-cache openjdk8

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH ${PATH}:${JAVA_HOME}/jre/bin:${JAVA_HOME}/bin

RUN set -x \
  # Install Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy
  # https://github.com/floragunncom/search-guard-ssl/issues/43
  && apk add --no-cache unzip \
  && curl -jksSLOH "Cookie: oraclelicense=accept-securebackup-cookie" \
      "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" \
  && unzip -jo -d ${JAVA_HOME}/jre/lib/security jce_policy-8.zip \*/\*.jar \
  && rm -f jce_policy-8.zip \
  && apk del --no-cache unzip \
  # Speed up Java with non-blocking /dev/urandom instead of blocking /dev/random
  # https://docs.oracle.com/cd/E13209_01/wlcp/wlss30/configwlss/jvmrand.html
  && sed -i \
      -e 's;securerandom.source=file:/dev/random;securerandom.source=file:/dev/urandom;' \
      -e 's;securerandom.strongAlgorithms=NativePRNGBlocking;securerandom.strongAlgorithms=NativePRNGNonBlocking;' \
      ${JAVA_HOME}/jre/lib/security/java.security \
  # Set DNS caching to 30s
  # https://github.com/floragunncom/search-guard-ssl/issues/43
  && sed -i \
      -e 's;#networkaddress.cache.ttl=-1;networkaddress.cache.ttl=30;' \
      ${JAVA_HOME}/jre/lib/security/java.security \
  ;

COPY docker-entrypoint.d /docker-entrypoint.d
