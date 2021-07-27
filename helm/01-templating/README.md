# Шаблонизатор Helm 
Шаблонизатор Helm используется в очень многих проектах. Это практически стандарт де-факто. 

Шаблонизатор построен на базе шаблонизатора языка **golang**.

## Создание своего первого чарта

```shell script
# Создание чарта first в папке charts
helm create charts/first

# Сборка ресурсов из шаблона 
helm template charts/first

# Linter
helm lint charts/first
```

## Типы чартов
- application
- library

## Файловая структура
[Файловая структура](https://helm.sh/docs/topics/charts/#the-chart-file-structure)

## Переменные
Переменные помещены в файлы `values.yaml`. В шаблонах доступ к переменным осуществляется через выражение `.Values`. 
Могут присутствовать в корневом чарте и в дочерних чартах.
Переменные могут быть переопределены с помощью флага --set. И с помощью другого файла.
```shell script
# Сборка шаблона с переопределением параметра
helm template --set namespace=demo charts/01-simple

# Сборка шаблона с переопределением двух параметров
helm template --set namespace=demo,appPort=8080, charts/01-simple

# Сборка шаблона с переопределением параметра в файле
helm template -f charts/01-simple/new-values.yaml charts/01-simple
```
Способы переопределения переменных могут сочетаться.
  
Родительский чарт имеет доступ ко всем дочерним переменным. Дочерние чарты могут получить доступ к переменным родительского чарта только через определение [глобальных](https://helm.sh/docs/chart_template_guide/subcharts_and_globals/) переменных.
В шаблонах доступ к глобальным переменным осуществляется через выражение `.Values.global`.

### Дополнительная информация
- [Файлы с переменными](https://helm.sh/docs/chart_template_guide/values_files/)
- [Переменные](https://helm.sh/docs/chart_template_guide/variables/)


## Встроенные объекты
Объекты, к которым есть доступ в любом шаблоне:
- Release
- Values
- Chart
- Files 
- Capabilities
- Template

Подробнее про [встроенные объекты](https://helm.sh/docs/chart_template_guide/builtin_objects/)


## Функции шаблонизатора и pipeline
[Функции шаблонизатора и pipeline](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/)

```
# Взять в кавычки переменную
{{ .Values.favorite.drink | quote }}

# Перевести переменную в верхний регистр и взять в кавычки
{{ .Values.favorite.drink | upper | quote }}
```

## Функции шаблонизатора
Известно около 50 функций шаблонизатора Helm. [Список функций](https://helm.sh/docs/chart_template_guide/function_list/).

required - Требование наличия переменной. При ее отсутствии выводит сообщение.

## Именованные шаблоны
[Именованные шаблоны](https://helm.sh/docs/chart_template_guide/named_templates/)

