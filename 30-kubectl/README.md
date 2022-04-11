# Kubectl
## Материалы
- [Обзор](https://kubernetes.io/ru/docs/reference/kubectl/overview/)
- [Cheatsheet](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/)
- [Completion](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/#bash)

## Полезные команды
```shell script
# Доступные в кластере ресурсы
kubectl api-resources

# Спецификации ресурса
kubectl explain pod

# Подробности о конкретном ресурсе
kubectl describe nodes master

# Подробности о наборе ресурсов
kubectl describe nodes
```

## Детальная информация
- [Конфиг](00-kube-config/README.md)
- [Файлы](10-files.md)
- [get](20-get.md)
- [describe](25-describe.md)
- [Просмотр логов](30-logs.md)
- [Редактирование ресурсов](40-edit.md)
- [Scale](45-scale.md)
- [Выполнение команд](60-exec.md)
- [Редактирование меток](70-labels.md)
- [Редактирование аннотаций](75-annotations.md)
- [Port forwarding](80-port-forward.md)
- [Получение спецификации ресурса](90-explain.md)
- [Удаление зависших ресурсов](99-terminating.md)
