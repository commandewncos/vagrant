#!/bin/bash
sudo apt-get update --yes
sudo apt-get install apt-transport-https --yes

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update --yes
sudo apt-get install kubelet=1.32.3-1.1 kubeadm=1.32.3-1.1 kubectl=1.32.3-1.1 --yes
sudo apt-mark hold kubelet=1.32.3-1.1 kubeadm=1.32.3-1.1 kubectl=1.32.3-1.1
sudo systemctl enable --now kubelet





# implemented: https://forum.linuxfoundation.org/discussion/862825/kubeadm-init-error-cri-v1-runtime-api-is-not-implemented
# mdevitis
# mdevitis Posts: 4
# January 2023
# By searching the web it appears this is an issue with the old containerd provided by Ubuntu 20.
# I solved it with the following steps (as root):
# 1. Set up the Docker repository as described in https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository
# 2. Remove the old containerd:apt remove containerd
# 3. Update repository data and install the new containerd: apt update, apt install containerd.io
# 4. Remove the installed default config file: rm /etc/containerd/config.toml
# 5. Restart containerd: systemctl restart containerd

sudo apt remove containerd
sudo apt-get update --yes
sudo apt install containerd.io --yes
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
sudo kubeadm config images pull
