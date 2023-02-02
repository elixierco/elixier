Introduction
=============

Elixier is a data platform stack on Kubernetes.

Quickstart
=============

Dependencies
-------------

- Some knowledge on Kubernetes, `kubectl`, `helm` and `k3s` 

  - https://docs.k3s.io/quick-start

  - https://docs.k3s.io/cluster-access

  - https://helm.sh/docs/intro/quickstart/

- You need at least 100GB free space, preferably SSD

- At least 16 vCore with 32GB RAM is recommended, or you might face issue where kubernetes unable to allocate resources for the services, or services crashing. 8vCore with 16GB RAM can still work, but do not enable elixier-security, auto scaling and high availability. 

Installation
--------------

1. Prepare the OS:

   Install OS dependencies. Assuming you are on CentOS/RHEL:

   ```bash
   dnf install iscsi-initiator-utils nfs-utils tar git -y
   ```

   disable firewalld as it will interfere with container networking:

   ```bash
   systemctl stop firewalld
   systemctl disable firewalld 
   ```

   set `vm.max_map_count` for opensearch:

   ```bash
   echo vm.max_map_count=262144 > /etc/sysctl.d/00-vm-max-map-count.conf
   sysctl --system
   ```

2. Install K3S:

   ```bash
   curl -sfL https://get.k3s.io | sh -
   ```

3. Install helm:

   ```bash
   curl -sfL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sh -
   ```

4. Install longhorn:

   ```bash
   kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/longhorn.yaml
   ```

   To check for deployment status, run `watch kubectl get pods --namespace=longhorn-system`. Wait until all longhorn services are operational.

5. Clone:

   ```bash
   git clone https://github.com/elixierdata/helm elixier
   ```

6. Setup `longhorn-single` storage class for single node installation:

   ```bash
   kubectl apply -f elixier/k8s-components/storageclass-longhorn-single.yaml
   kubectl patch storageclass longhorn -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
   kubectl patch storageclass longhorn-single -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```

7. Install

   ```bash
   export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
   cd elixier/helm/elixier 
   helm install --set storageClass=longhorn-single elixier .
   ```

   To check for deployment status, run  `watch kubectl get pods`. 

8. Configure hosts

   Edit your hosts file (`/etc/hosts` in Linux, `C:\Windows\System32\drivers\etc\hosts` in Windows), add the 
   following entry (replace `<ip-address>` with the IP address of the k3s server:

   ```
   <ip-address> airflow.elixier.lan gitweb.elixier.lan jupyterhub.elixier.lan minio.elixier.lan minio-console.elixier.lan presto.elixier.lan superset.elixier.lan 
   ```

Accessing Services
-------------------

- Airflow (http://airflow.elixier.lan/). Default user: `admin`. Default password: `admin`.

- Gitweb (http://gitweb.elixier.lan/git/). Default user: `user`. Default password: `password`.

- Jupyterhub (http://jupyterhub.elixier.lan/). Sign up user `admin` to set default password.

- Minio S3 API endpoint (http://minio.elixier.lan/). Default user: `minio`. Default password: `miniopassword`.

- Minio UI (http://minio-console.elixier.lan/). Default user: `minio`. Default password: `miniopassword`.

- Presto UI (http://presto.elixier.lan).

- Presto Connection URI for `default` catalog (presto://presto.elixier.lan:80/default).

- Superset (http://superset.elixier.lan/). Default user: `admin`. Default password: `admin`.
