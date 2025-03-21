```shell
sudo kubeadm token generate 
#example: lniywx.pzq8imwenmzo0j37

sudo kubeadm token "lniywx.pzq8imwenmzo0j37"create --print-join-command 



# Your Kubernetes control-plane has initialized successfully!

# To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

# You should now deploy a pod network to the cluster.
# Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
#   https://kubernetes.io/docs/concepts/cluster-administration/addons/

# Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.56.30:6443 --token lniywx.pzq8imwenmzo0j37 \
--discovery-token-ca-cert-hash sha256:83cea2d05e1eaba825daa3d81dbcf51fa3dafb693184ab52ce957e2225734feb 



# allow traffic port 6443 and 8080
sudo ufw allow 6443
sudo ufw allow 8080

sudo systemctl restart kubelet


kubectl apply --filename https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/controllers/nginx-deployment.yaml
```