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

4. Clone:

   ```bash
   git clone https://github.com/elixierco/elixier elixier
   ```

5. Install Elixier. Please replace `${IP_ADDRESS}` with the main IP address of the server

   ```bash
   export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
   helm install --set storageAccessMode=ReadWriteOnce \
                --set ingress.domain=${IP_ADDRESS}.sslip.io \
                elixier \
                elixier/helm/elixier
   ```

   To check for deployment status, run  `watch kubectl get pods`. 

Accessing Services
-------------------

- Airflow (`https://airflow.${IP_ADDRESS}.sslip.io/`). Default user: `admin`. Default password: `admin`.

- Gitweb (`https://gitweb.${IP_ADDRESS}.sslip.io/git/`). Default user: `user`. Default password: `password`.

- Jupyterhub (`https://jupyterhub.${IP_ADDRESS}.sslip.io/`). Sign up user `admin` to set default password.

- Minio S3 API endpoint (`https://minio.${IP_ADDRESS}.sslip.io/`). Default user: `minio`. Default password: `miniopassword`.

- Minio UI (`https://minio-console.${IP_ADDRESS}.sslip.io/`). Default user: `minio`. Default password: `miniopassword`.

- Presto UI (`https://presto.${IP_ADDRESS}.sslip.io`).

- Presto Connection URI for `default` catalog (`presto://presto.${IP_ADDRESS}.sslip.io:80/default`).

- Superset (`https://superset.${IP_ADDRESS}.sslip.io/`). Default user: `admin`. Default password: `admin`.


Community
===========

Join our discord server at https://discord.gg/MFTrhZn4jr
