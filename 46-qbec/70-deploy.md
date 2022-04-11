# Развертывание (deploy)

```shell script
qbec apply --help

qbec apply default
qbec apply default --wait-all --yes
qbec apply default --show-details

qbec delete default
# Удаление компонентов с именем rabbitmq
qbec delete default -c rabbitmq

# Не будет установлен если предварительно не создать namespace под него 
qbec apply prod

watch 'kubectl -n qbec-prod get po'
kubectl create ns qbec-prod
```
