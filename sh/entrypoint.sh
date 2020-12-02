#!/usr/bin/env bash

if [ -d /.ssh ]; then
  rm -rf /root/.ssh
  cp -rf /.ssh /root/.ssh
else
  mkdir -p /root/.ssh
  printf "Host *\n\tStrictHostKeyChecking no\n" >/root/.ssh/config
  # shellcheck disable=SC2059
  [ "${SSHCLI_SSH_ID_ACCESS}" != "" ] && printf -- "${SSHCLI_SSH_ID_ACCESS//\"/}\n" >/root/.ssh/id_rsa
  # shellcheck disable=SC2059
  [ "${SSHCLI_SSH_CONFIG}" != "" ] && printf "${SSHCLI_SSH_CONFIG//\"/}\n" >>/root/.ssh/config
fi &&
  chown -R root:root /root/.ssh &&
  touch /root/.ssh/config &&  touch /root/.ssh/id_rsa &&
  chmod 600 /root/.ssh/config &&  chmod 600 /root/.ssh/id_rsa &&
  set -x && "$@"
