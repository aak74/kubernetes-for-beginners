# Выполнение команд
Команда: 
```shell script
kubectl exec <pod name> -- <command>
```
## Флаги
- -с — выбор контейнера для выполнения;
- -it — интерактивный доступ.

## Примеры
```shell script
kubectl exec -it hello -- bash
kubectl exec -it hello -c app -- bash
kubectl exec hello -c app -- sh -c 'ls -la /var/www/html'
```
