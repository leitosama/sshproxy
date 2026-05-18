#!/usr/bin/env sh
set -e
/bin/chmod -R 600 /.ssh &
/usr/bin/ssh -v -o StrictHostKeyChecking=no -i /.ssh/$KEY_NAME -D 0.0.0.0:9050 -N $SSH_HOST
