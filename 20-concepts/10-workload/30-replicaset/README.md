# ReplicaSet
[Документация](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)

Пришел на замену устаревшему ресурсу [ReplicationController](https://kubernetes.io/docs/reference/glossary/?all=true#term-replication-controller).

Обеспечивает версионирование и масштабирование подов.
В один и тот же момент времени могут существовать несколько ReplicaSet c одним набором подов.

Напрямую ReplicaSet используется довольно редко. 
В моей практике я обращаюсь к replicaset только для устранения поломок.

## Демо
```shell script
kubectl get rs
```

Имя ReplicaSet состоит из имени Deployment + 10 символьный hash
Например `grafana-5c8fb4c656`.

Поды, которые созданы этим ReplicaSet, будут иметь имя вида: `grafana-5c8fb4c656-69qb2`. 
