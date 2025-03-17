    control: 
    control: Your Kubernetes control-plane has initialized successfully!
    control: 
    control: To start using your cluster, you need to run the following as a regular user:
    control: 
    control:   mkdir -p $HOME/.kube
    control:   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    control:   sudo chown $(id -u):$(id -g) $HOME/.kube/config
    control: 
    control: Alternatively, if you are the root user, you can run:
    control: 
    control:   export KUBECONFIG=/etc/kubernetes/admin.conf
    control: 
    control: You should now deploy a pod network to the cluster.
    control: Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
    control:   https://kubernetes.io/docs/concepts/cluster-administration/addons/
    control: 
    control: Then you can join any number of worker nodes by running the following on each as root:
    control: 
    control: kubeadm join 192.168.56.30:6443 --token fvia0x.u6t5rc68v6bnbuhw \
    control:    --discovery-token-ca-cert-hash sha256:64933defdf43d67c2897d7130ca09afcba8e677e6ad59e52520174032d0980cc