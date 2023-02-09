#!/usr/bin/env sh

if [ -z "${DAVIS__MAIL_USERNAME}" ] && [ -z "${DAVIS__MAIL_PASSWORD}" ]; then
  export MAILER_DSN="smtp://${DAVIS__MAIL_HOST}:${DAVIS__MAIL_PORT:-25}"
else
  export MAILER_DSN="smtp://${DAVIS__MAIL_USERNAME}:${DAVIS__MAIL_PASSWORD}@${DAVIS__MAIL_HOST}:${DAVIS__MAIL_PORT:-25}"
fi

export DATABASE_DRIVER=postgresql
export DATABASE_URL="postgresql://${DAVIS__POSTGRES_USERNAME}:${DAVIS__POSTGRES_PASSWORD}@${DAVIS__POSTGRES_HOST}:${DAVIS__POSTGRES_PORT:-5432}/${DAVIS__POSTGRES_DATABASE}?charset=UTF-8&sslmode=${DAVIS__POSTGRES_SSLMODE:-require}"

export ADMIN_LOGIN="${DAVIS__ADMIN_LOGIN}"
export ADMIN_PASSWORD="${DAVIS__ADMIN_PASSWORD}"

export AUTH_REALM="${DAVIS__AUTH_REALM}"
export AUTH_METHOD="${DAVIS__AUTH_METHOD}"

export CALDAV_ENABLED="${DAVIS__CALDAV_ENABLED}"

export CARDDAV_ENABLED="${DAVIS__CARDDAV_ENABLED}"

export WEBDAV_ENABLED="${DAVIS__WEBDAV_ENABLED}"
export WEBDAV_TMP_DIR="${DAVIS__WEBDAV_TMP_DIR}"
export WEBDAV_PUBLIC_DIR="${DAVIS__WEBDAV_PUBLIC_DIR}"

export INVITE_FROM_ADDRESS="${DAVIS__INVITE_FROM_ADDRESS}"

export IMAP_AUTH_URL="${DAVIS__IMAP_AUTH_URL}"
export IMAP_AUTH_USER_AUTOCREATE="${DAVIS__IMAP_AUTH_USER_AUTOCREATE:-false}"

export LDAP_AUTH_URL="${DAVIS__LDAP_AUTH_URL}"
export LDAP_AUTH_USER_AUTOCREATE="${DAVIS__LDAP_AUTH_USER_AUTOCREATE:-false}"
export LDAP_DN_PATTERN="${DAVIS__LDAP_DN_PATTERN:-mail=%u}"
export LDAP_MAIL_ATTRIBUTE="${DAVIS__LDAP_MAIL_ATTRIBUTE:-mail}"

bin/console doctrine:migrations:migrate --no-interaction
exec "$@"
