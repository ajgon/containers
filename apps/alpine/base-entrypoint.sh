#!/usr/bin/env sh
# shellcheck shell=dash
set -eu

# STEP 1:
# Scans the environment variables for those with the suffix _FILE
# When located, checks the file exists, and exports the contents
# of the file as the same name, minus the suffix
# This allows the use of Docker secrets or mounted files
# to fill in any of the settings configurable via environment
# variables

for line in $(printenv)
do
  env_name=${line%%=*}
  if [ -z "${env_name##*"_FILE"*}" ]; then # checks if env_name ends with _FILE
    env_value=${line#*=}

    if [ -f "${env_value}" ]; then
      non_file_env_name=${env_name%"_FILE"}
      echo "Setting ${non_file_env_name} from file"

      val="$(head -n 1 "${env_value}")"
      export "${non_file_env_name}"="${val}"
    else
      echo "File ${env_value} referenced by ${env_name} doesn't exist"
    fi
  fi
done

exec "$@"
