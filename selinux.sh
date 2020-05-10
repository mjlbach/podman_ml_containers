#!/bin/bash

###
#
# Based on the work found here:
# https://github.com/NVIDIA/dgx-selinux
#
###

# Create temp dir
tmp_dir=$(mktemp -d /tmp/nvidia-selinux-XXXXX)

# Prereqs
yum install -y git

# Get selinux module source
git clone https://github.com/NVIDIA/dgx-selinux $tmp_dir/dgx-selinux

# Inject newly compiled SELinux module
semodule -i $tmp_dir/dgx-selinux/bin/RHEL7/nvidia-container.pp

# Set contexts for SELinux
nvidia-container-cli -k list | restorecon -v -f -
restorecon -Rv /dev

# Run test container with podman
podman run --user 1000:1000 --network=host --security-opt label=type:nvidia_container_t mirrorgooglecontainers/cuda-vector-add:v0.1
