USERNAME=$(whoami)
DOCKER_GROUP=$(getent group docker | awk -F: '{printf $3}')
sudo podman build -t cuda_dev_10_1 --format=docker --build-arg USERNAME=$USERNAME --build-arg DOCKER_GROUP=$DOCKER_GROUP .
