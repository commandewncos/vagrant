#!/bin/bash

KUBERNETES_VESRSION="1.32.3-1.1"
PACKAGES=("docker.io" "docker-doc" "docker-compose" "docker-compose-v2" "podman-docker" "containerd" "runc")

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
  net.ipv4.ip_forward = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
sysctl net.ipv4.ip_forward

for PACKAGE in ${PACKAGES[@]}
do 
  sudo apt-get remove $PACKAGES
done

# Add Docker's official GPG key:
sudo apt-get update --yes
sudo apt-get upgrade --yes
sudo apt-get install ca-certificates curl apt-transport-https gpg --yes
sudo install --mode=0755 --directory /etc/apt/keyrings
sudo curl --fail \
    --silent \
    --show-error \
    --location https://download.docker.com/linux/ubuntu/gpg \
  --output /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update --yes
sudo apt-get install containerd.io --yes

sudo containerd config default > /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl status containerd

sudo swapoff --all
sudo curl --fail \
    --silent \
    --show-error \
    --location https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | \
        sudo gpg --dearmor --output /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update --yes
sudo apt-get install kubelet=$KUBERNETES_VESRSION kubeadm=$KUBERNETES_VESRSION kubectl=$KUBERNETES_VESRSION --yes 
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
