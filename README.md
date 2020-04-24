# podman_ml_containers

### Description

This is a collection of Dockerfiles and utility scripts for use with podman to facilitate ML research. I was motivated to create these for running various iterations of projects that depended on older CUDA versions. The containers are set up for X forwarding and can run opengl applications as they are based on the nvidia opengl containers, rather than solely the CUDA containers.


### Instructions

1. Install podman and nvidia-container-toolkit
``` bash
dnf install podman
dnf config-manager --add-repo https://nvidia.github.io/nvidia-docker/centos7/nvidia-docker.repo
dnf install nvidia-container-toolkit
```

2. Set up OCI hooks
```
https://github.com/NVIDIA/nvidia-container-runtime/issues/85#issuecomment-604931556
https://github.com/containers/libpod/issues/3155
```
3. Run build_container.sh 

4. Run start_container.sh

### Caveats/things of note

* Podman can be run rootless, but nvidia-docker requires use of sudo/--privileged
* A mock home directory is created in $(pwd)/.containers/$USER, so your virtual environments should remain rootless
* Make sure your DISPLAY variable is set correctly
* Some of the containers contain unnecessary packages related to my personal setup/preferences
* /etc/group and /etc/passwd are forwarded into the container to share the local X server, which has the consequence of preventing the use of apt inside the container
* You cannot directly use apt in the container due to forwarding /etc/group, which leads to:
```
dpkg: unrecoverable fatal error, aborting:
 unknown group 'messagebus' in statoverride file
E: Sub-process /usr/bin/dpkg returned an error code (2)
```
* Forwarding /etc/passwd into the container causes a harmless error message (No user _apt) in the container
*


