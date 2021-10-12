# Network Policy
Объект NetworkPolicy служит для разграничения доступа между подами.

[Документация](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Для исследования работы принципов Network Policy рекомендую использовать инструмент [Network-MultiTool](https://github.com/Praqma/Network-MultiTool).

Этот образ содержит все необходимые для этого инструменты.


Вот пример желаемого поведения:
![NetworkPolicy](./images/network-policy.png)

## Настройка NetworkPolicy
В нашем приложении реализовано 3 сервиса:
- frontend; 
- backend; 
- cache.

Откуда берутся данные в cache оставим за скобками данного упражнения.
 
Выглядит разумным обеспечить доступ:
- frontend -> backend;
- backend -> cache.

Остальные возможные взаимодействия должны быть запрещены. 

## Проверка доступности между подами с flannel
Сначала развертываем в кластере с установленным CNI плагином flannel.
В этом плагине не реализована работа с NetworkPolicy.

Выдвинем две гипотезы:
1. Без настройки NetworkPolicy все поды будут доступны между собой.
1. После настройки NetworkPolicy все поды будут все еще доступны между собой.

### Развертывание
Для начала необходимо развернуть объекты из подготовленных манифестов.
```shell script
# Развертывание
kubectl apply -f ./templates/main/

# Проверка созданных подов
kubectl get po
``` 

### Проверка доступности между подами
```shell script
kubectl -n default exec backend-7b4877445f-8mwvr -- curl -s frontend
kubectl -n default exec backend-7b4877445f-8mwvr -- curl -s cache
kubectl -n default exec backend-7b4877445f-8mwvr -- curl -s backend
```
В случае отсутствия запретов все поды будут доступны. 
Подобный эксперимент можно провести из любого из созданных подов.

Например:
```shell script
kubectl -n default exec frontend-7f74b5fd7-qsv46 -- curl -s frontend
kubectl -n default exec frontend-7f74b5fd7-qsv46 -- curl -s cache
kubectl -n default exec frontend-7f74b5fd7-qsv46 -- curl -s backend
```

Гипотеза подтвердилась.

### Применение NetworkPolicy
```shell script
kubectl apply -f ./templates/network-policy

kubectl get networkpolicies
```

### Проверка доступности между подами после применения NetworkPolicy
Выполняем те же самые команды. Результат ожидаемо такой же.
А именно все поды доступны со всех подов.

Вторая гипотеза тоже подтвердилась.

Из этого можно сделать вывод, что для работы NetworkPolicy необходим CNI плагин с поддержкой NetworkPolicy.
Одним из таких плагинов является calico.

## Проверка доступности между подами с calico
Повторим эксперимент с проверкой доступности на кластере, на котором используется calico.

Установить такой кластер можно с помощью kubespray. Как это сделать рассматривалось [тут](../../15-install/30-kubespray/README.md).

Снова выдвинем 2 гипотезы:
1. Без настройки NetworkPolicy все поды будут доступны между собой.
1. После настройки NetworkPolicy `backend` будет доступен из `frontend`, `cache` будет доступен из `backend`. Все остальные маршруты будут запрещены.

Проверим это по прежней схеме.

Команды здесь не указаны, потому что они полностью повторяются. 

После проверки можно увидеть, что 1 гипотеза не подтвердилась. Без настройки NetworkPolicy вообще ничего не работает.
Это говорит, что в calico работает режим: "Все что явно не разрешено - то запрещено". 

Вторая гипотеза подтвердилась полностью.

## Выводы
Для обеспечения безопасной работы с сетью необходимо выполнить 2 пункта:
1. Использовать CNI плагин с поддержкой NetworkPolicy.
1. Необходимо правильно настроить NetworkPolicy.
