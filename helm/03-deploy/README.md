# Deploy

## Команды
```shell script
# Release deploy
helm install demo-release charts/01-simple
kubectl get ns
kubectl -n helm get deploy demo -o jsonpath={.spec.template.spec.containers[0].image}

# Upgrade release
helm upgrade demo-release charts/01-simple

# Upgrade or install release
helm upgrade --install demo-release charts/01-simple

# Uninstall release
helm uninstall demo-release

# Установка релиза в новый namespace с переопределением параметров
helm install new-release -f charts/01-simple/new-values2.yaml charts/01-simple
kubectl -n new get deploy demo -o jsonpath={.spec.template.spec.containers[0].image}

# Просмотр пользовательских переменных
helm get values demo-release
helm get values new-release

# Список релизов
helm list

# Отладка
helm install --dry-run --debug aaa --set namespace=aaa charts/01-simple
```

## Жизненный цикл
[Подробное описание](https://helm.sh/docs/topics/charts_hooks/)

