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
Для DaemonSet название пода состоит из 2 компонентов:
- имени DaemonSet;
- 5 символьного hash (идентификатор Pod).

Например `node-exporter-2zfqx`.

У пода, который создан с помощью Deployment, имя будет состоять из компонентов:
- имени Deployment;
- 10 символьного хэша (идентификатор ReplicaSet);
- 5 символьного hash (идентификатор Pod).

Например `grafana-5c8fb4c656-69qb2`. Тут `grafana-5c8fb4c656` имя ReplicaSet.

## Пример манифеста DaemonSet
Примеры можно увидеть в папке `manifests`. 
