# Labels
Labels используются для селекторов, указания версий приложения и прочего.

## Команда и флаги
```shell script
kubectl label <type> <label>
``` 

Флаги:
- --all — обновление всех ресурсов в неймспейсе;

## Редактирование меток

```shell script
# Показать все ноды
kubectl get nodes

# Поставить метку на ноду node1
kubectl label node node1 test=db

# Варианты просмотра меток
kubectl get nodes node1 -o yaml 
kubectl get nodes node1 --show-labels
kubectl get nodes node1 -o jsonpath='{.metadata.labels}'
kubectl get nodes node1 -o jsonpath='{.metadata.labels.test}'

# Удаление метки
kubectl label node node1 test-
kubectl get nodes 10.0.10.100 -o jsonpath='{.metadata.labels}'
``` 
