#!/usr/bin/env sh
set -e

: "${SSH_HOST:?SSH_HOST is required}"

SSH_USER="${SSH_USER:-root}"
SSH_PORT="${SSH_PORT:-22}"
SOCKS_PORT="${SOCKS_PORT:-9050}"

BASE_ARGS="-o StrictHostKeyChecking=accept-new -D 0.0.0.0:${SOCKS_PORT} -N -p ${SSH_PORT}"

if [ -n "${SSH_PRIVATE_KEY}" ]; then
    echo "${SSH_PRIVATE_KEY}" > /tmp/ssh_key
    chmod 600 /tmp/ssh_key
    exec /usr/bin/ssh ${BASE_ARGS} -i /tmp/ssh_key ${SSH_EXTRA_ARGS} "${SSH_USER}@${SSH_HOST}"
elif [ -n "${SSH_PASSWORD}" ]; then
    export SSHPASS="${SSH_PASSWORD}"
    exec /usr/bin/sshpass -e /usr/bin/ssh ${BASE_ARGS} ${SSH_EXTRA_ARGS} "${SSH_USER}@${SSH_HOST}"
else
    : "${KEY_NAME:?One of SSH_PRIVATE_KEY, SSH_PASSWORD, or KEY_NAME must be set}"
    chmod 600 "/.ssh/${KEY_NAME}"
    exec /usr/bin/ssh ${BASE_ARGS} -i "/.ssh/${KEY_NAME}" ${SSH_EXTRA_ARGS} "${SSH_USER}@${SSH_HOST}"
fi
