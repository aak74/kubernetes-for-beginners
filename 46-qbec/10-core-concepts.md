# Основные концепции
Конечной целью qbec является развертывание компонентов в разные окружения. Обычно это разные кластеры. Например prod и stage кластеры. 
Но это могут быть и разные namespace в одном кластере. 

## Компоненты (components)
Компоненты это код, который представляет Kubernetes объекты. Обычно в один компонент помещают все Kubernetes объекты, которые представляют собой ваше приложение.
Часто в один компонент помещают такие объекты: `service account`, `deployment`, `service`, `config map` и другие.

В рамках одного приложения может быть более одного компонента.

Компоненты загружаются из jsonnet, json или yaml файлов. Но только jsonnet файлы обеспечивают возможность кастомизировать объекты для различных окружений.
Qbec поддерживает загрузку объектов из helm чартов, и использует jsonnet библиотеки для их генерации.

Подробнее смотри в [документации](https://qbec.io/userguide/model/userguide/authoring/).

## Окружения (environments)
Компоненты применяются к окружению. Окружение - это кластер, представленный URL-адресом сервера и пространством имен, которое может быть указано дополнительно.
Это позволяет использовать следующие варианты:
- Каждая среда представляет собой отдельный кластер.
В этом кластере развертываются компоненты.
В таком случае вы можете свободно создавать объекты с областью действия кластера (ClusterRole, ClusterRoleBinding и др.).
А также можете создавать объекты K8s в нескольких пространствах имен.
- Можно определить несколько сред для одного кластера, используя разные пространства имен.
В этом случае вы можете создавать только объекты с областью действия одного пространства имен.
При использовании этого подхода из метаданных следует удалить определения пространства имен.

```shell script
# Посмотреть все описанные среды 
qbec env list
```

## Манифест приложения (application manifest)
Для работы qbec необходимо наличие файла `qbec.yaml` в корне проекта.
В этом файле указывается название вашего приложения и определение среды, куда должно развертываться приложение.

Минимальный манифест выглядит вот так:
```yaml
apiVersion: qbec.io/v1alpha1
kind: App
metadata:
  name: my-app
spec:
  environments:
    default:
      server: https://minikube:8443 
      defaultNamespace: my-ns
```
Детальная информация в [соответствующем](https://qbec.io/reference/qbec-yaml) разделе документации.

## Компоненты специфические для разных сред
Все необходимые компоненты помещаются в папку `components` вашего приложения.
Вы можете изменить список используемых компонентов для каждого окружения.
Для этого нужно изменить файл `qbec.yaml`.

[Пример](./20-next/README.md)

Способы включения и исключения компонентов.
- Укажите список компонентов, которые не должны включаться ни в одну среду.
- Укажите явные списки включения и исключения для каждой среды.

Это означает, что:
- Компонент, который исключен по умолчанию, должен быть явно включен в среду, чтобы компонент мог быть применен там.
- Компонент, который был бы включен по умолчанию, может быть явно исключен для среды.

Тут речь о секциях excludes и includes файла `qbec.yaml`. Эти секции могут быть включены:
- в секцию spec на том же уровне, что и environments;
- в секцию отдельного environment.

## Базовое окружение (baseline environment)
Напомню, что окружения определяются в манифесте приложения. В дополнение к ним qbec автоматически добавляет базовое окружение.
Которое именуется как `_`. Это окружение не предназначено для развертывания. 
Поэтому вы не увидите кластера с таким именем.
Это окружение используется для команд, которые выполняются локально без развертывания на кластере.
Список таких команд: `show`, `component`, подкоманды `param`.
Сравните вывод:
```shell script
qbec show _
qbec show default

# Список переменных для окружения
qbec param list _
qbec param list default

# Diff между переменными окружения и базовым окружением
qbec param diff default
```

## Конфигурация базовых параметров запуска
Разные окружения требуют разных параметров запуска. Это включает число реплик, версии образов, специфические `config maps`, разные секреты и т.д.
   
qbec устанавливает jsonnet переменную с именем `qbec.io/env` со значением имени окружения в момент загрузки компонентов. 
Вы можете использовать значение этой переменной для установки параметров для каждого окружения.
Обратите внимание, что для некоторых вызовов среда может быть установлена в `_` (представляющий базовый уровень). 
Ваш код должен правильно обработать это и возвращать значения по умолчанию.
   
qbec не предписывает придерживаться определенной файловой структуры для определения параметров.
Основные команды, такие как `apply`, `show` и `diff`, будут работать независимо от того, как вы настроили параметры среды выполнения.

Тем не менее, подкоманды `param` ожидают, что конфигурация среды выполнения будет настроена определенным образом. Более подробную информацию об этом можно найти в разделе [папки и файлы](https://qbec.io/userguide/usage/basic) руководства пользователя.   

## Конфигурация позднего связывания
Некоторые параметры конфигурации, такие как теги образа и секреты, создаются только в момент развертывания.
Такие параметры не должны указываться в исходном коде. 

Для этих ситуаций qbec предоставляет способ объявить переменные jsonnet, которые необходимо передать со значениями по умолчанию.

Это позволяет вам не передавать эти дополнительные аргументы при локальной разработке компонентов. 
Но при этом у вас остается возможность параметризовать их в вашей сборке CI.
Более подробную информацию об этой функции можно найти в разделе [Параметры среды выполнения](https://qbec.io/userguide/usage/runtime-params) руководства пользователя.   
