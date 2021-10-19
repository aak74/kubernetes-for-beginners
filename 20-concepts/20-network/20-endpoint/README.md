# Endpoint

## Возможности
- объединяет сервис с подами по селекторам, которые указаны в спецификации сервиса;
- можно создать вручную;
- имена Endpoint и Service совпадают;
- позволяет направлять трафик наружу из кластера.

Если для сервиса указан селектор, то EndPoint будет создан автоматически.
В противном случае этот объект нужно будет создать вручную. 
Имя EndPoint должно соответствовать спецификации [DNS subdomain name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names#dns-subdomain-names).

По спецификации указанной в сервисе создается endpoint c IP адресами всех подходящих подов.

## Демо
```shell script
kubectl describe ep main
kubectl get ep main -o yaml
kubectl get svc main -o yaml
kubectl describe svc main
```
