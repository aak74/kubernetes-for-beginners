# Установка Kubernetes с помощью kubespray
[Документация](https://kubespray.io/)

## Подготовка
Склонируйте себе репозиторий:
```shell script
git clone https://github.com/kubernetes-sigs/kubespray
```

```shell script
# Установка зависимостей
sudo pip3 install -r requirements.txt

# Копирование примера в папку с вашей конфигурацией
cp -rfp inventory/sample inventory/mycluster
```

## Конфигурация
После установки зависимостей и подготовки шаблона с конфигурацией необходимо подготовить inventory файл.
Этот файл будет содержать конфигурацию вашего кластера.

Тут возможны два варианта:
- запуск билдера и ручная правка `hosts.yaml` при необходимости;
- ручная правка `inventory.ini`.
Эти способы равнозначны. Их использование зависит только от ваших личных предпочтений.

Практически любой параметр кластера может быть сконфигурирован.
Минимальный набор параметров такой:
- имена нод;
- роли нод;
- ноды, на которых будет запущен etcd;
- CNI плагин;
- CRI плагин.

### Конфигурация с запуском билдера
Подготовьте список IP адресов и скопируйте их через пробел в первую команду.  
```shell script
# Обновление Ansible inventory с помощью билдера 
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# 10.10.1.3 10.10.1.4 10.10.1.5 - адреса ваших серверов
```
Билдер подготовит файл `inventory/mycluster/hosts.yaml`. Там будут прописаны адреса серверов, которые вы указали.
Остальные настройки нужно делать самостоятельно.

#### Пример hosts.yaml
```yaml
all:
  hosts:
    cp1:
      ansible_host: 51.250.42.98
      ansible_user: yc-user
    node1:
      ansible_host: 51.250.47.60
      ansible_user: yc-user
  children:
    kube_control_plane:
      hosts:
        cp1:
    kube_node:
      hosts:
        cp1:
        node1:
    etcd:
      hosts:
        cp1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```

### Конфигурация без запуска билдера 
Далее необходимо отредактировать файл `inventory/mycluster/inventory.ini` в соответствии с вашими предпочтениями.

## Установка кластера
Вне зависимости от предыдущего шага установка кластера производится однообразно.
Меняется только указываемый `inventory` файл для playbook.

Установка кластера занимает значительное количество времени.
Время установки кластер из двух нод может занять более 10 минут.
Чем больше нод, тем больше времени занимает установка.

### Установка кластера после билдера 
```shell script
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v
```

### Установка кластера без билдера 
```shell script
ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml -b -v
```

## Проверка установки
```shell script
kubectl version
kubectl get nodes

kubectl create deploy nginx --image=nginx:latest --replicas=2
kubectl get po -o wide
```

## Добавление ноды
```shell script
ansible-playbook -i inventory/mycluster/hosts.yml scale.yml -b -v
```

## Удаление ноды
```shell script
ansible-playbook -i inventory/mycluster/hosts.yml remove-node.yml -b -v \
  --private-key=~/.ssh/private_key \
  --extra-vars "node=nodename,nodename2
```

## Доступ к кластеру
Для доступа к кластеру извне нужно добавить параметр
`supplementary_addresses_in_ssl_keys: [51.250.42.98]` в файл inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
Заново запустить установку кластера.
После этого кластер будет доступен извне.
