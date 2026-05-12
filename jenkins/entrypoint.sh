#!/bin/bash
# Match the docker group GID inside the container to the host socket's GID
# so Testcontainers and docker CLI both work without running as root.
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
groupmod -g "$DOCKER_GID" docker
usermod -aG docker jenkins

exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
