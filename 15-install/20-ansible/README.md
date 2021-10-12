# Установка Kubernetes с помощью ansible

## Установка control plane ноды
```shell script
ansible-playbook setup-control-plane.yml -i hosts -b -v
```

## Установка worker нод
```shell script
ansible-playbook setup-worker.yml -i hosts -b -v
```

## Добавление worker нод
```shell script
ansible-playbook setup-worker.yml -i hosts -b -v
```

## Проверка результата установки
```shell script
kubectl version
kubectl get nodes

kubectl create deploy nginx --image=nginx:latest --replicas=2
kubectl get po -o wide
```
