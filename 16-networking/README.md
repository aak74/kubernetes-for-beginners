# Сеть в Kubernetes
Официальная документация:
Cluster Networking [документация](https://kubernetes.io/docs/concepts/cluster-administration/networking/)
Service Networking [документация](https://kubernetes.io/docs/concepts/services-networking/)

Статьи про сеть в Kubernetes:
- [За кулисами сети в Kubernetes](https://habr.com/ru/company/flant/blog/420813/)
- [Эксперименты с kube-proxy и недоступностью узла в Kubernetes](https://habr.com/ru/company/flant/blog/359120/)
- [Иллюстрированное руководство по устройству сети в Kubernetes. Части 1 и 2](https://habr.com/ru/company/flant/blog/346304/)
- [Иллюстрированное руководство по устройству сети в Kubernetes. Часть 3](https://habr.com/ru/company/flant/blog/433382/)

## Сетевая модель Kubernetes
Факты про устройство сети в Kubernetes:
- у каждого pod-а свой уникальный IP;
- IP pod-а делится между всеми его контейнерами;
- pod является доступным (маршрутизируемым) для всех остальных подов;
- на каждой ноде свой CIDR, из этого диапазона адресов и выделяются IP для pod-ов.

## Сеть на нодах 
Зайдем на каждую из нод и убедимся в том, что на ноде создан отдельный диапазон сети. 
И из этого диапазона выделяются IP для подов.

Сначала смотрим на таблицу маршрутизации:
```shell script
# Таблица маршрутизации
route -n
```

Пример вывода для первой ноды:
```shell script
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.0.1        0.0.0.0         UG    100    0        0 eth0
10.0.0.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
10.0.0.1        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
10.10.129.0     0.0.0.0         255.255.255.0   U     0      0        0 cbr0
172.17.0.0      0.0.0.0         255.255.255.0   U     0      0        0 docker0
```

Пример вывода для второй ноды:
```shell script
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.0.1        0.0.0.0         UG    100    0        0 eth0
10.0.0.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
10.0.0.1        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
10.10.130.0     0.0.0.0         255.255.255.0   U     0      0        0 cbr0
172.17.0.0      0.0.0.0         255.255.255.0   U     0      0        0 docker0
```

Проверка распределения подов по нодам:
```shell script
kubectl get po -o wide
```
Обратите внимание на 4 октет IP адреса и имя ноды. 
