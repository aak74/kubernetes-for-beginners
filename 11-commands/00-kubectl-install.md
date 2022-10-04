# Установка kubectl
Инструкция по [установке](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

```shell
# Download binary file
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Download hash
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Validate the binary
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Valid output:
# kubectl: OK

# Install binary
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```
