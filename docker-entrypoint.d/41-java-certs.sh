#!/bin/bash

debug0 "Processing $(basename ${DOCKER_ENTRYPOINT:-$0})"

# Convert CA certificate to Java truststore
if [ -e ${CA_CRT} -a ! -e ${CA_TRUSTSTORE} ]; then
  info "Building truststore ${CA_TRUSTSTORE}"
  # Import CA certificate to truststore
  keytool -importcert \
    -file           "${CA_CRT}" \
    -keystore       "${CA_TRUSTSTORE}" \
    -storepass      "${SERVER_KEY_PWD}" \
    -trustcacerts \
    -noprompt
fi

# Convert server pkcs12 to Java keystore
if [ -e ${SERVER_P12} -a ! -e ${SERVER_KEYSTORE} ]; then
  info "Building keystore ${SERVER_KEYSTORE}"
  keytool -importkeystore \
    -alias          1 \
    -srcstoretype   pkcs12 \
    -srckeystore    "${SERVER_P12}" \
    -srcstorepass   "${SERVER_KEY_PWD}" \
    -srckeypass     "${SERVER_KEY_PWD}" \
    -destalias      1 \
    -destkeystore   "${SERVER_KEYSTORE}" \
    -deststorepass  "${SERVER_KEY_PWD}" \
    -destkeypass    "${SERVER_KEY_PWD}" \
    -noprompt
  # Set keystore permissions
  if [ -n "${DOCKER_USER}" ]; then
    chown ${DOCKER_USER}:${DOCKER_USER} ${SERVER_KEYSTORE}
  fi
  chmod o-rwx ${SERVER_KEYSTORE}
fi
