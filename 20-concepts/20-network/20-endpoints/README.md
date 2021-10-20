# Endpoints

## Возможности
- объединяет сервис с подами по селекторам, которые указаны в спецификации сервиса;
- можно создать вручную;
- имена Endpoints и Service совпадают;
- позволяет направлять трафик наружу из кластера.

Если для сервиса указан селектор, то объект Endpoints будет создан автоматически.
В противном случае этот объект нужно будет создать вручную. 
Имя Endpoints должно соответствовать спецификации [DNS subdomain name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names#dns-subdomain-names).

По спецификации указанной в сервисе создается endpoint c IP адресами всех подходящих подов.

## Демо
```shell script
kubectl describe ep main
kubectl get ep main -o yaml
kubectl get svc main -o yaml
kubectl describe svc main
```

## Пример манифеста Endpoints
```yaml
apiVersion: v1
kind: Endpoints
metadata:
  name: db-slave
  namespace: db-conn
subsets:
  - addresses:
      - ip: 10.128.0.21
      - ip: 10.128.0.22
    ports:
      - port: 5432
```
 
