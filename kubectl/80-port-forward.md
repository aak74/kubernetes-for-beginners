# Port forwarding

Команда: kubectl port-forward <type>/<name> <port>
Как можно задать порты:
- 8000 9000 — сразу несколько;
- 9000:http — по названию в сервисе/поде;
- 8080:80 — с локального 8080 на порт 80 пода;
- :80 — на свободный локальный порт.

```shell script
# Перенаправление локального порта 8080 на порт 80 пода
kubectl port-forward pods/hello 8080:80

# Перенаправление локального порта 8080 на порт 80 одного из подов deployment demo
kubectl port-forward deploy/demo 8080:80

# Перенаправление локального порта 8080 на порт 80 одного из подов service demo
kubectl port-forward service/demo 8080:80

# Перенаправление порта и debug информация по выполнению команды
kubectl port-forward service/demo 8080:web --v=9
```
