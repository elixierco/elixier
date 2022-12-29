Quickstart
=============

Dependencies
-------------

- Some knowledge on Kubernetes, `kubectl` and `k3s` (https://docs.k3s.io/quick-start) (https://docs.k3s.io/cluster-access)

- You need at least 100GB free space, preferably SSD

Installation
--------------

1. Install K3S:

   ```bash
   curl -sfL https://get.k3s.io | sh -
   ```

2. Install helm:

   ```bash
   https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sh -
   ```

3. Clone:

   ```bash
   git clone https://github.com/elixierdata/helm elixier
   ```

4. Install

   ```bash
   cd elixier/helm/elixier 
   helm install --set storageAccessMode=ReadWriteOnce elixier .
   ```

   To check for deployment status, run  `watch kubectl get pods`. 

5. Configure hosts

   Edit your hosts file (`/etc/hosts` in Linux, `C:\Windows\System32\drivers\etc\hosts` in Windows), add the 
   following entry (replace `<ip-address>` with thee IP address of the k3s server:

   ```
   <ip-address> airflow.elixier.lan gitweb.elixier.lan jupyterhub.elixier.lan minio.elixier.lan minio-console.elixier.lan presto.elixier.lan superset.elixier.lan 
   ```

Accessing Services
-------------------

- Airflow (http://airflow.elixier.lan/). Default user: `admin`. Default password: `admin`.

- Gitweb (http://gitweb.elixier.lan/). Default user: `user`. Default password: `password`.

- Jupyterhub (http://jupyterhub.elixier.lan/). Sign up user `admin` to set default password.

- Minio S3 API endpoint (http://minio.elixier.lan/). Default user: `minio`. Default password: `miniopassword`.

- Minio UI (http://minio-console.elixier.lan/). Default user: `minio`. Default password: `miniopassword`.

- Presto UI (http://presto.elixier.lan).

- Presto Connection URI for `default` catalog (presto://presto.elixier.lan:80/default).

- Superset (http://superset.elixier.lan/). Default user: `admin`. Default password: `admin`.
