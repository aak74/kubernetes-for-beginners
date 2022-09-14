# Labels
Labels (метки) - пары ключ/значение присоединенные к объекту.
Labels предназначены для уточнения объектов значимых для пользователей. Могут быть использованы при ручном поиске или в качестве селекторов.
Labels могут быть присоединены к объектам во время их создания, или добавлены позже в любое время.
Каждый объект может иметь набор из нескольких labels. Каждый ключ должен быть уникальным в рамках объекта.
При росте размера кластера увеличивается количество похожих объектов. С целью облегчения фильтрации объектов вводят labels. 
[Подробнее](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)

## Команда и флаги
```shell script
kubectl label <type> <label>
``` 

Флаги:
- --all — обновление всех ресурсов в неймспейсе;

## Редактирование меток

```shell script
# Показать все ноды
kubectl get nodes
kubectl get nodes --show-labels

# Поставить метку на ноду node1
kubectl label node node1 test=db

# Варианты просмотра меток
kubectl get nodes node1 -o yaml 
kubectl get nodes node1 --show-labels
kubectl get nodes node1 -o jsonpath='{.metadata.labels}'
kubectl get nodes node1 -o jsonpath='{.metadata.labels.test}'

# Удаление метки
kubectl label node node1 test-
kubectl get nodes node1 -o jsonpath='{.metadata.labels}'
``` 

## Необычное применение
Deployment создает ReplicaSet. 
ReplicaSet создает Pod и устанавливает ему label pod-template-hash.
Значение берет из своей одноименной метки.

### Изменяем значение метки у Pod-а
Если изменить значение метки у пода, то Pod будет отвязан от ReplicaSet.
Количество подов привязанных к ReplicaSet уменьшится. Поэтому будет создан еще один Pod.

Общее количество подов станет больше желаемого.

### Возвращаем значение метки Pod-у
Если вернуть значение метки поду, то Pod будет снова привязан к ReplicaSet.
Количество подов привязанных к ReplicaSet увеличится. Их станет больше чем должно быть у ReplicaSet.  
Поэтому один из Pod-ов будет удален.

Общее количество подов придет к желаемому.
