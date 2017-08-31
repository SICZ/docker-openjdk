#!/bin/bash

### JAVA_TRUSTSTORE ############################################################

# Convert CA certificate to Java truststore
if [ -e ${CA_CRT_FILE} -a ! -e ${JAVA_TRUSTSTORE_FILE} ]; then

  # Get Java truststore passphrase
  if [ -n "${JAVA_TRUSTSTORE_PWD_FILE}" -a -e "${JAVA_TRUSTSTORE_PWD_FILE}" ]; then
    info "Using Java truststore passphrase from ${JAVA_TRUSTSTORE_PWD_FILE}"
    JAVA_TRUSTSTORE_PWD=$(cat ${JAVA_TRUSTSTORE_PWD_FILE})
  elif [ -z "${JAVA_TRUSTSTORE_PWD}" ]; then
    info "Creating random Java truststore passphrase"
    JAVA_TRUSTSTORE_PWD=$(openssl rand -hex 32)
  fi

  # Save Java truststore passphrase
  if [ -n "${JAVA_TRUSTSTORE_PWD_FILE}" -a ! -e "${JAVA_TRUSTSTORE_PWD_FILE}" ]; then
    info "Saving Java truststore passphrase to ${JAVA_TRUSTSTORE_PWD_FILE}"
    echo ${JAVA_TRUSTSTORE_PWD} > ${JAVA_TRUSTSTORE_PWD_FILE}
    if [ -n "${JAVA_TRUSTSTORE_FILE_OWNER}" ]; then
      debug "Changing owner of ${JAVA_TRUSTSTORE_PWD_FILE} to ${JAVA_TRUSTSTORE_FILE_OWNER}"
      chown ${JAVA_TRUSTSTORE_FILE_OWNER} ${JAVA_TRUSTSTORE_PWD_FILE}
    fi
    debug "Changing mode of ${JAVA_TRUSTSTORE_PWD_FILE} to ${JAVA_TRUSTSTORE_FILE_MODE}"
    chmod ${JAVA_TRUSTSTORE_FILE_MODE} ${JAVA_TRUSTSTORE_PWD_FILE}
  fi

  # Import CA certificate to truststore
  info "Creating Java truststore file ${JAVA_TRUSTSTORE_FILE}"
  keytool -importcert \
    -file           "${CA_CRT_FILE}" \
    -alias          "ca.crt" \
    -keystore       "${JAVA_TRUSTSTORE_FILE}" \
    -storepass      "${JAVA_TRUSTSTORE_PWD}" \
    -trustcacerts \
    -noprompt

  # Set permissions
  if [ -n "${JAVA_TRUSTSTORE_FILE_OWNER}" ]; then
    debug "Changing owner of ${JAVA_TRUSTSTORE_FILE} to ${JAVA_TRUSTSTORE_FILE_OWNER}"
    chown ${JAVA_TRUSTSTORE_FILE_OWNER} ${JAVA_TRUSTSTORE_FILE}
  fi
  debug "Changing mode of ${JAVA_TRUSTSTORE_FILE} to ${JAVA_TRUSTSTORE_FILE_MODE}"
  chmod ${JAVA_TRUSTSTORE_FILE_MODE} ${JAVA_TRUSTSTORE_FILE}

fi

### JAVA_KEYSTORE ##############################################################

# Convert server PKCS12 keystore to Java keystore
if [ -e ${SERVER_P12_FILE} -a ! -e ${JAVA_KEYSTORE_FILE} ]; then

  # Get Java keystore passphrase
  if [ -n "${JAVA_KEYSTORE_PWD_FILE}" -a -e "${JAVA_KEYSTORE_PWD_FILE}" ]; then
    info "Using Java keystore passphrase from ${JAVA_KEYSTORE_PWD_FILE}"
    JAVA_KEYSTORE_PWD=$(cat ${JAVA_KEYSTORE_PWD_FILE})
  elif [ -z "${JAVA_KEYSTORE_PWD}" ]; then
    info "Creating random Java keystore passphrase"
    JAVA_KEYSTORE_PWD=$(openssl rand -hex 32)
  fi

  # Save Java keystore passphrase
  if [ -n "${JAVA_KEYSTORE_PWD_FILE}" -a ! -e "${JAVA_KEYSTORE_PWD_FILE}" ]; then
    info "Saving Java keystore passphrase to ${JAVA_KEYSTORE_PWD_FILE}"
    echo ${JAVA_KEYSTORE_PWD} > ${JAVA_KEYSTORE_PWD_FILE}
    if [ -n "${JAVA_KEYSTORE_FILE_OWNER}" ]; then
      debug "Changing owner of ${JAVA_KEYSTORE_PWD_FILE} to ${JAVA_KEYSTORE_FILE_OWNER}"
      chown ${JAVA_KEYSTORE_FILE_OWNER} ${JAVA_KEYSTORE_PWD_FILE}
    fi
    debug "Changing mode of ${JAVA_KEYSTORE_PWD_FILE} to ${JAVA_KEYSTORE_FILE_MODE}"
    chmod ${JAVA_KEYSTORE_FILE_MODE} ${JAVA_KEYSTORE_PWD_FILE}
  fi

  # Convert server PKCS12 keystore to Java keystore
  info "Creating Java keystore file ${JAVA_KEYSTORE_FILE}"
  keytool -importkeystore \
    -alias          1 \
    -srcstoretype   pkcs12 \
    -srckeystore    "${SERVER_P12_FILE}" \
    -srcstorepass   "${SERVER_KEY_PWD}" \
    -srckeypass     "${SERVER_KEY_PWD}" \
    -destalias      "server.crt" \
    -destkeystore   "${JAVA_KEYSTORE_FILE}" \
    -deststorepass  "${JAVA_KEYSTORE_PWD}" \
    -destkeypass    "${JAVA_KEYSTORE_PWD}" \
    -noprompt

  # Set permissions
  if [ -n "${JAVA_KEYSTORE_FILE_OWNER}" ]; then
    debug "Changing owner of ${JAVA_KEYSTORE_FILE} to ${JAVA_KEYSTORE_FILE_OWNER}"
    chown ${JAVA_KEYSTORE_FILE_OWNER} ${JAVA_KEYSTORE_FILE}
  fi
  debug "Changing mode of ${JAVA_KEYSTORE_FILE} to ${JAVA_KEYSTORE_FILE_MODE}"
  chmod ${JAVA_KEYSTORE_FILE_MODE} ${JAVA_KEYSTORE_FILE}
fi

################################################################################
