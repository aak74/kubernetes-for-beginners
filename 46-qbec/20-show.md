# Просмотр результатов

```shell script
# Вывод всех компонентов в формате yaml
qbec show default
# Вывод всех компонентов в формате yaml для кластера stage
qbec show stage

# Вывод компонента postgres
qbec show default -c postgres

# Вывод всех компонентов в формате json
qbec show default -o json 

# Вывод всех компонентов с типом deployment
qbec show default -k deployment
```

При генерации добавляет labels и annotations.

```shell script
# Выводит список компонентов в окружении
qbec component list default

# Выводит отдельные компоненты в окружении
qbec component list default -O
```
