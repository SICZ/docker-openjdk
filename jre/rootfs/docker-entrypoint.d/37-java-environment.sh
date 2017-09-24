#!/bin/bash -e

### SERVER_P12_FILE ############################################################

# Default server PKCS12 file location
if [ -e /run/secrets/server.p12 ]; then
  : ${SERVER_P12_FILE:=/run/secrets/server.p12m}
else
  : ${SERVER_P12_FILE:=${SERVER_KEY_DIR}/server.p12}
fi

### JAVA_TRUSTSTORE_FILE #######################################################

# Default Java truststore
: ${JAVA_TRUSTSTORE_DIR:=${SERVER_CRT_DIR}}
: ${JAVA_TRUSTSTORE_FILE_NAME:=truststore.jks}
: ${JAVA_TRUSTSTORE_FILE_OWNER:=${SERVER_CRT_FILE_OWNER}}
: ${JAVA_TRUSTSTORE_FILE_MODE:=${SERVER_CRT_FILE_MODE}}
if [ -e /run/secrets/${JAVA_TRUSTSTORE_FILE_NAME} ]; then
  : ${JAVA_TRUSTSTORE_FILE:=/run/secrets/${JAVA_TRUSTSTORE_FILE_NAME}}
else
  : ${JAVA_TRUSTSTORE_FILE:=${JAVA_TRUSTSTORE_DIR}/${JAVA_TRUSTSTORE_FILE_NAME}}
fi

### JAVA_TRUSTSTORE_PWD_FILE ###################################################

# Default Java truststore passphrase file
: ${JAVA_TRUSTSTORE_PWD_FILE_NAME:=truststore.pwd}
if [ -e /run/secrets/${JAVA_TRUSTSTORE_PWD_FILE_NAME} ]; then
  : ${JAVA_KEYSTORE_PWD_FILE:=/run/secrets/${JAVA_TRUSTSTORE_PWD_FILE_NAME}}
elif [ -e ${JAVA_TRUSTSTORE_DIR}/${JAVA_TRUSTSTORE_PWD_FILE_NAME} ]; then
  : ${JAVA_KEYSTORE_PWD_FILE:=${JAVA_TRUSTSTORE_DIR}/${JAVA_TRUSTSTORE_PWD_FILE_NAME}}
fi

### JAVA_KEYSTORE_FILE #########################################################

# Default Java keystore file
: ${JAVA_KEYSTORE_DIR:=${SERVER_KEY_DIR}}
: ${JAVA_KEYSTORE_FILE_NAME:=keystore.jks}
: ${JAVA_KEYSTORE_FILE_OWNER:=${SERVER_KEY_FILE_OWNER}}
: ${JAVA_KEYSTORE_FILE_MODE:=${SERVER_KEY_FILE_MODE}}
if [ -e /run/secrets/${JAVA_KEYSTORE_FILE_NAME} ]; then
  : ${JAVA_KEYSTORE_FILE:=/run/secrets/${JAVA_KEYSTORE_FILE_NAME}}
else
  : ${JAVA_KEYSTORE_FILE:=${JAVA_KEYSTORE_DIR}/${JAVA_KEYSTORE_FILE_NAME}}
fi

### JAVA_KEYSTORE_PWD_FILE #####################################################

# Default Java keystore passphrase file
: ${JAVA_KEYSTORE_PWD_FILE_NAME:=keystore.pwd}
if [ -e /run/secrets/${JAVA_KEYSTORE_PWD_FILE_NAME} ]; then
  : ${JAVA_KEYSTORE_PWD_FILE:=/run/secrets/${JAVA_KEYSTORE_PWD_FILE_NAME}}
elif [ -e ${JAVA_KEYSTORE_DIR}/${JAVA_KEYSTORE_PWD_FILE_NAME} ]; then
  : ${JAVA_KEYSTORE_PWD_FILE:=${JAVA_KEYSTORE_DIR}/${JAVA_KEYSTORE_PWD_FILE_NAME}}
fi

################################################################################
