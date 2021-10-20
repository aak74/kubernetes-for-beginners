# DaemonSet
[Документация](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
DaemonSet создает по одному поду на каждой ноде.
Обычно используется для системных целей. 
Например на каждой ноде создаются поды CNI плагина flannel или node-exporter.

## Демо
```shell script
kubectl get ds
```

У Deployment и DaemonSet отличаются именования созданных подов.
Для DaemonSet название пода заканчивается числом после дефиса. 
Например `node-exporter-2zfqx`.
У пода, который создан с помощью Deployment (ReplicaSet), имя будет заканчиваться 5 символьным hash.
Например `grafana-5c8fb4c656-69qb2`. Тут `grafana-5c8fb4c656` имя ReplicaSet.

## Пример манифеста DaemonSet
Примеры можно увидеть в папке `templates`. 
