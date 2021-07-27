# Первый шаг
```shell script
# Сборка
helm template charts/01-simple

# Сборка шаблона с переопределением параметра
helm template --set namespace=demo charts/01-simple

# Сборка шаблона с переопределением двух параметров
helm template --set namespace=demo,appPort=8080, charts/01-simple

# Просмотр изменений
helm template charts/01-simple | grep namespace
helm template --set namespace=demo charts/01-simple | grep namespace

# Просмотр изменений с использованием diff
diff <(helm template charts/01-simple) <(helm template --set appPort=8080,namespace=demo charts/01-simple)

# Сборка шаблона с переопределением параметра в файле
helm template -f charts/01-simple/new-values.yaml charts/01-simple
helm template -f charts/01-simple/new-values.yaml charts/01-simple | grep nginx

# Сборка шаблона с переопределением параметра в нескольких файлах
helm template -f charts/01-simple/new-values.yaml -f charts/01-simple/new-values2.yaml charts/01-simple | grep nginx
```
