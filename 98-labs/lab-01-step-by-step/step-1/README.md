# Шаг 1

## Namespace
```shell script
# Создание namespace
kubectl apply -f manifests/00-namespace.yaml

## Проверяем созданный namespace
kubectl get ns
```

## Pod
### Создание
```shell script
# Создание namespace
kubectl apply -f manifests/00-namespace.yaml 

# Создание пода
kubectl apply -f manifests/10-pod.yaml

# Проверяем созданный под
kubectl -n lab1 get po
```

Pod создан. 

### Проверка
```shell script
# Проверяем созданный под
kubectl -n lab1 get po

# Направим трафик с локального компьютера на pod
kubectl port-forward -n lab1 pods/frontend 8080:80
# Трафик с адреса 127.0.0.1:8080 будет направлен внутрь пода

# В соседней вкладке терминала
curl 127.0.0.1:8080
```

Pod отвечает. Но это направляет только трафик с нашего компьютера. 
При завершении работы команды `kubectl port-forward` перенаправление трафика завершится.  
Нужно на этот pod направить трафик из публичной сети.

## Service
Внешний трафик в сеть можно направить с помощью объекта Service.  
Создадим Service типа NodePort.

