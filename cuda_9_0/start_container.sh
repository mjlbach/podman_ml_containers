mkdir -p .container/$USER

sudo podman run \
       -it \
       --rm \
       -u $(id -u):$(id -g) \
       --privileged \
       --workdir \
       /home/$USER \
       --env \
       DISPLAY=$DISPLAY \
       --volume \
       $(pwd)/.container/$USER:/home/$USER:z \
       --volume \
       $HOME/Repositories:/home/$USER/Repositories:z \
       --volume \
       $HOME/Documents:/home/$USER/Documents:z \
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
       cuda_dev_9_0 \
       --network \
       host \
       cuda_dev_9_0 \
       zsh
