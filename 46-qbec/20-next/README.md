# Второй уровень

## Генерация yaml
```shell script
qbec show _ -k Service
qbec show _ -k Deployment

qbec show prod
qbec show stage


# Diff между компонентами для prod и stage. В stage компонентов больше. Конфигурация через excludes в qbec.yaml
qbec component diff prod stage

# Diff между компонентами для default и hello2. В hello2 компонентов больше. Конфигурация через includes в qbec.yaml
qbec component diff default hello2
```

## Deploy
```shell script


kubectl port-forward <pod> 8080:80
curl 127.1:8080

kubectl -n qbec-prod port-forward <pod> 8081:80
curl 127.1:8081

```
