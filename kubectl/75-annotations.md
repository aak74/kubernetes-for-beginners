# Annotations
Annotations используются для подсказок контроллеру для создания специфических настроек.
[Подробнее](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).
Очень хороший пример использования аннотаций:
[Nginx configuration annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/)

## Команда и флаги
```shell script
kubectl annotate <type> <label>
``` 

Флаги:
- --all — обновление всех ресурсов в неймспейсе;


## Пример использования аннотаций
```shell
# Устанавливает whitelist для доступа к ingress
kubectl -n test annotate ingress demo nginx.ingress.kubernetes.io/whitelist-source-range=10.0.10.0/24
```
