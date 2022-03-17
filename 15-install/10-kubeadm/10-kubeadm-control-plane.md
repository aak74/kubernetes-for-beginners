# Установка Kubernetes (containerd runtime) с помощью kubeadm
[Инструкция по установке](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)

## Установка минимального набора ПО
```shell script
{
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl containerd
    sudo apt-mark hold kubelet kubeadm kubectl
}
```

## Инициализация кластера

### Первая попытка
```shell script
# Смотрим адрес, который прописан на сервере  
ip a

# Указываем адрес в параметрах, добавляем внешний адрес
# Инициализация кластера
kubeadm init \
  --apiserver-advertise-address=10.0.90.13 \
  --pod-network-cidr 10.244.0.0/16 \
  --apiserver-cert-extra-sans=178.154.234.213
```

### Исправление ошибки
```shell script
# При проверке возникнет ошибка. Исправим ее.
# Для сохранения работоспособности после перезагрузки сервера выполним такие команды:
modprobe br_netfilter 
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-arptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=1" >> /etc/sysctl.conf

sysctl -p /etc/sysctl.conf
```

### Вторая попытка
```shell script
# Инициализация кластера
kubeadm init \
  --apiserver-advertise-address=10.0.90.13 \
  --pod-network-cidr 10.244.0.0/16 \
  --apiserver-cert-extra-sans=178.154.234.213
```
Со второй попытки все удалось.

Копируем команду вида:
```shell script
kubeadm join 10.0.90.13:6443 --token hwbgbw.32k0dapxd5bp5gbj \
        --discovery-token-ca-cert-hash sha256:293acadbd04d38feeddfd5a110d4fa3a14869b4a62348e480bc7f97748be8f2e 
```
Эта команда нам понадобиться для подключения к кластеру рабочей ноды.

### Доступ к управлению кластером под root
```shell script
# Копируем конфиг в домашнюю папку пользователя для управления кластером 
{
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}
``` 

### Проверка состояния кластера 
```shell script
kubectl get nodes
``` 
Есть нода master1, но она в состоянии NotReady.

Выясним в чем причина:
```shell script
kubectl describe nodes master1 | grep KubeletNotReady

# Результат:
#  Ready            False   Wed, 06 Oct 2021 21:46:39 +0300   Wed, 06 Oct 2021 21:26:26 +0300   KubeletNotReady              container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized
```
Причина в том, что не установлен CNI plugin. Установим plugin flannel.
```shell script
# Установка CNI flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
После установки сетевого плагина нода переходит в состояние Ready.
Теперь можно приступать к добавлению ноды. 


## Настройка доступа к кластеру 
### На master node под непривилегированным пользователем
Пользоваться root не рекомендуется. Поэтому настроим доступ к кластеру под обычным пользователем. 

Запускаем консоль под непривилегированным пользователем.
```shell script
# Копируем конфиг в домашнюю папку пользователя для управления кластером 
{
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}
```

### Настройка доступа к кластеру c локального компа  
Для переноса настроек в свой локальный ~/.kube/config выполните:
```shell script
cat $HOME/.kube/config
```
Перенесите эти настройки в локальный `~/.kube/config`.

Если адрес при создании кластера был указан внутренний, а обращаться к kube-apiserver вы планируете по внешнему, то не забудьте изменить адрес.

## Если что-то пошло не так
```shell script
# Сброс кластера
kubeadm reset

# Проблемы с cgroup
cat > /etc/containerd/config.toml <<EOF
[plugins."io.containerd.grpc.v1.cri"]
  systemd_cgroup = true
EOF
systemctl restart containerd

# Просмотр запущенных контейнеров
crictl ps -a
crictl logs POD_ID
```

Документация по [crictl](https://kubernetes.io/docs/tasks/debug-application-cluster/crictl/)

## Установка с первой попытки
### Установка минимального набора ПО
```shell script
{
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl containerd
    sudo apt-mark hold kubelet kubeadm kubectl

    modprobe br_netfilter 
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
    echo "net.bridge.bridge-nf-call-arptables=1" >> /etc/sysctl.conf
    echo "net.bridge.bridge-nf-call-ip6tables=1" >> /etc/sysctl.conf
    
    sysctl -p /etc/sysctl.conf
}
```
### Инициализация кластера
```shell script
ip a

# Указываем адрес в параметрах, добавляем внешний адрес
# Инициализация кластера
kubeadm init \
  --apiserver-advertise-address=10.0.90.13 \
  --pod-network-cidr 10.244.0.0/16 \
  --apiserver-cert-extra-sans=178.154.234.213
```
### Копирование доступов и загрузка плагина CNI flannel 
```shell script
{
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
}
```

Control plane нода установлена.
