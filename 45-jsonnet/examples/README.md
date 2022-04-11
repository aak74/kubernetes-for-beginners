# Примеры
```shell script
# Простой пример 
jsonnet 10-example.jsonnet

# Использование функции 
jsonnet 20-example.jsonnet

# Генерация валидного yaml. По сравнению с json элементы массива отделяются символами ---
jsonnet -y 30-yaml.jsonnet

# Генерация json из того же файла
jsonnet 30-yaml.jsonnet

# Генерация нескольких файлов из одного конфига
jsonnet -m multiple-output 40-multiple-output.jsonnet

# Импорт шаблона, импорт функции, передача параметра 

# Генерация json с передачей параметра
jsonnet 50-imports.jsonnet --ext-str env=prod

# Генерация yaml
jsonnet -y 50-imports.jsonnet --ext-str env=prod
```
