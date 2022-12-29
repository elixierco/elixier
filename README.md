Installation
=============

You need at least 100GB free spacee

1. Install K3S:

```bash
curl -sfL https://get.k3s.io | sh -
```

2. Install helm:

```bash
https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sh -
```

2. Clone:

```bash
git clone https://github.com/elixierdata/helm elixier
```

3. Install

```bash
cd elixier/helm/elixier 
helm install --set storageAccessMode=ReadWriteOnce elixier .
```
