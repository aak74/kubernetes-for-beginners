# Первый шаг
```shell script
# Сборка
helm template 01-simple

# Сборка шаблона с переопределением параметра
helm template --set replicaCount=3 01-simple

# Сборка шаблона с переопределением двух параметров
helm template --set replicaCount=3,appPort=8080, 01-simple

# Просмотр изменений
helm template 01-simple | grep namespace
helm template --set replicaCount=3 01-simple | grep namespace

# Просмотр изменений с использованием diff
diff <(helm template 01-simple) <(helm template --set appPort=8080,replicaCount=3 01-simple)

# Сборка шаблона с переопределением параметра в файле
helm template -f 01-simple/new-values.yaml 01-simple
helm template -f 01-simple/new-values.yaml 01-simple | grep nginx

# Сборка шаблона с переопределением параметра в нескольких файлах
helm template -f 01-simple/new-values.yaml -f 01-simple/new-values2.yaml 01-simple | grep nginx

# Сборка шаблона с переопределением параметра в нескольких файлах
helm template -f 01-simple/new-values.json 01-simple | grep memory

# Сохранение файла yaml для тестирования helm шаблонизатора
jsonnet -y 50-imports.jsonnet --ext-str env=prod -o ../../helm/01-templating/01-simple/values.yaml
```
