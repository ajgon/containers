# davis

## Custom environment configuration

| Name                               | Default   | Notes                       |
|------------------------------------|-----------|-----------------------------|
| `DAVIS__ADMIN_LOGIN`               |           |                             |
| `DAVIS__ADMIN_PASSWORD`            |           |                             |
| `DAVIS__AUTH_METHOD`               | `Basic`   | `Basic`, `IMAP` or `LDAP`   |
| `DAVIS__AUTH_REALM`                |           | Realm name                  |
| `DAVIS__CALDAV_ENABLED`            |           | `true`/`false`              |
| `DAVIS__CARDDAV_ENABLED`           |           | `true`/`false`              |
| `DAVIS__IMAP_AUTH_URL`             |           | For `IMAP` auth method only |
| `DAVIS__IMAP_AUTH_USER_AUTOCREATE` | `false`   | For `IMAP` auth method only |
| `DAVIS__INVITE_FROM_ADDRESS`       |           |                             |
| `DAVIS__LDAP_AUTH_URL`             |           | For `LDAP` auth method only |
| `DAVIS__LDAP_AUTH_USER_AUTOCREATE` | `false`   | For `LDAP` auth method only |
| `DAVIS__LDAP_DN_PATTERN`           | `mail=%u` | For `LDAP` auth method only |
| `DAVIS__LDAP_MAIL_ATTRIBUTE`       | `mail`    | For `LDAP` auth method only |
| `DAVIS__MAIL_HOST`                 |           |                             |
| `DAVIS__MAIL_PASSWORD`             |           | Can be skipped              |
| `DAVIS__MAIL_PORT`                 | `25`      |                             |
| `DAVIS__MAIL_USERNAME`             |           | Can be skipped              |
| `DAVIS__POSTGRES_DATABASE`         |           |                             |
| `DAVIS__POSTGRES_HOST`             |           |                             |
| `DAVIS__POSTGRES_PASSWORD`         |           |                             |
| `DAVIS__POSTGRES_PORT`             | `5432`    |                             |
| `DAVIS__POSTGRES_SSLMODE`          | `require` |                             |
| `DAVIS__POSTGRES_USERNAME`         |           |                             |
| `DAVIS__WEBDAV_ENABLED`            |           | `true`/`false`              |
| `DAVIS__WEBDAV_PUBLIC_DIR`         |           |                             |
| `DAVIS__WEBDAV_TMP_DIR`            |           |                             |
