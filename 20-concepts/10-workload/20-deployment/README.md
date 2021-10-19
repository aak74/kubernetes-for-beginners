# Deployment
[Документация](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

## Возможности
- следит за количеством и статусом запущенных подов;
- позволяет масштабировать приложение;
- хранит шаблон конфигурации пода и позволяет обновлять его;
- для масштабирования и версионирования использует ReplicaSet.

Для одного и того же Deployment в одно и то же время существует несколько ReplicaSet-ов.
За это отвечает параметр revisionHistoryLimit. По умолчанию это 10 ReplicaSet-ов.

## Демо
```shell script
kubectl get deploy
kubectl get rs
```

Имя пода выглядит примерно так: `grafana-5c8fb4c656-69qb2`.
Тут `grafana-5c8fb4c656` имя ReplicaSet.
