mkdir -p .container/$USER

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

podman run -it \
	--rm \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
        --security-opt=label=type:nvidia_container_t \
        --volume \
            $(pwd)/.container/$USER:/home/$USER:z \
        --volume \
           /usr/bin/docker:/usr/bin/docker \
        --volume \
            /var/run/docker.sock:/var/run/docker.sock \
        --workdir \
            /home/$USER \
        --env="TERM=xterm-256color" \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY" \
        --user="michael" \
        --network host \
        --name cuda_dev_10_1 \
        cuda_dev_10_1 \
        zsh
