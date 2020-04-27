mkdir -p .container/$USER

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

sudo podman run -it \
	--rm \
        --privileged \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
        --volume \
            $(pwd)/.container/$USER:/home/$USER:z \
        --volume \
            $HOME/Repositories:/home/$USER/Repositories:z \
        --volume \
            $HOME/Documents:/home/$USER/Documents:z \
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
