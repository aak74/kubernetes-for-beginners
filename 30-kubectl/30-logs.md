# Просмотр логов
В большинстве случаев возможна работа только с логами одного пода.

## Полезные флаги 
- -c — уточнение контейнера;
- -p — просмотр логов прошлого запуска пода;
- --since — за какой период получить логи;
- --all-containers — получить логи всех контейнеров;
- -f — следить за логами в реальном времени.
- --tail=50 — брать последние 50 записей

Одновременное применение флагов `-l` и `-f` не допускается.

## Полезные команды
```shell script
# Просмотр логов всех подов с конкретным label 
kubectl -n ingress-nginx logs -l app.kubernetes.io/name=ingress-nginx --all-containers

# Просмотр логов одного из подов daemonsets nginx-ingress-controller
kubectl -n ingress-nginx logs -f daemonsets.apps/nginx-ingress-controller

# Просмотр логов контейнера с именем backend одного из подов deploy с именем api
kubectl logs -f deploy/api backend
```
