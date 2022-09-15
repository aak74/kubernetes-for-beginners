# Canary deploy
## Задача
Для тестирования нового приложения на небольшой части пользователей необходимо разворачивать две версии приложения.
И часть пользователей отправлять на новую версию приложения.

## Предлагаемое решение
Пользователей будем разделять по установленной cookie `canary`.
Если cookie `canary` установлена и равна `always`, то трафик будет направлен на новую версию приложения.
В противном случае трафик будет направлен на старую версию приложения.

[Документация](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#canary)

## Реализация
Для новой версии приложения необходимо создать `Deployment`, `Ingress`, `Service`.
Deployment и Service создаются стандартным способом.

Для Ingress нужно установить `annotations` как указано в следующим фрагменте манифеста:
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: default
  name: canary
  annotations:
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-by-cookie: canary
```

## Тестирование
Трафик направляется на стабильную версию приложения:
```shell
curl lab.akop.pw --cookie "canary=never"
curl lab.akop.pw --cookie "canary=123"
curl lab.akop.pw
```

Трафик направляется на новую версию приложения:
```shell
curl lab.akop.pw --cookie "canary=always"
```
