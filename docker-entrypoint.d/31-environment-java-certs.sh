#!/bin/bash

debug0 "Processing $(basename ${DOCKER_ENTRYPOINT:-$0})"

# Default server pkcs12 file location
if [ -e /run/secrets/server_crt.pem ]; then
  : ${SERVER_P12:=/run/secrets/server_p12.pem}
else
  : ${SERVER_P12:=${SERVER_KEY_DIR}/server_p12.pem}
fi

# Default CA truststore
: ${CA_TRUSTSTORE_NAME:=truststore.jks}
: ${CA_TRUSTSTORE:=${SERVER_CRT_DIR}/${CA_TRUSTSTORE_NAME}}

# Default server keystore
: ${SERVER_KEYSTORE_NAME:=keystore.jks}
: ${SERVER_KEYSTORE:=${SERVER_KEY_DIR}/${SERVER_KEYSTORE_NAME}}
