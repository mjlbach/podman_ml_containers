mkdir -p .container/$USER

podman run \
       -it \
       --rm \
       -u $(id -u):$(id -g) \
       --security-opt=label=type:nvidia_container_t \
       --workdir \
       /home/$USER \
       --env \
       DISPLAY=$DISPLAY \
       --volume \
       $(pwd)/.container/$USER:/home/$USER:z \
       -e "TERM=xterm-256color" \
       --volume \
       /etc/sudoers:/etc/sudoers:ro \
       --volume \
       /etc/group:/etc/group:ro \
       --volume \
       /etc/passwd:/etc/passwd:ro \
       --volume \
       /etc/shadow:/etc/shadow:ro \
       --volume \
       /etc/sudoers.d:/etc/sudoers.d:ro \
       --volume \
       /tmp/.X11-unix:/tmp/.X11-unix:rw \
       --volume \
       /usr/bin/docker:/usr/bin/docker \
       --volume \
       /var/run/docker.sock:/var/run/docker.sock \
       --name \
       cuda_dev_10_0 \
       --network \
       host \
       cuda_dev_10_0 \
       bash
