# get

## Примеры команд
```shell script
kubectl get nodes
kubectl get pods
kubectl get pods -o wide
kubectl get pods demo -o yaml
kubectl get pods demo -o json

# Имя образа первого контейнера в deployment grafana  
kubectl -n monitoring get deploy grafana -o jsonpath="{.spec.template.spec.containers[0].image}"
```

## Флаги
- -n уточнение namespace;
- -A, --all-namespaces все namespace.
