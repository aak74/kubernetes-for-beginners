# Просмотр спецификаций ресурса или части ресурса

## Примеры команд
```shell script
kubectl explain pod
kubectl explain ingress.spec
kubectl explain pod.spec.containers

# Посмотреть разницу между описаниями контейнеров в поде и деплойменте 
diff <(kubectl explain deploy.spec.template.spec.containers) <(kubectl explain pod.spec.containers)
```
