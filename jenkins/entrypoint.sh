#!/bin/bash
# Match the docker group GID to the host socket's GID so docker CLI and Testcontainers work.
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
groupmod -g "$DOCKER_GID" docker
usermod -aG docker jenkins

# Git 2.35.2+ refuses to run in directories owned by a different user when running as root.
git config --global --add safe.directory '*'

exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
