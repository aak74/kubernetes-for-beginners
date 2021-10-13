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

## Уровни погружения в устройство сети в Kubernetes
- [Первый уровень](10-level-1.md)
- [Второй уровень](20-level-2.md)
- [Третий уровень](30-level-3.md)

Есть уровни погружения и глубже. Это далеко за пределами курса для начинающих.

Если вам интересно дальнейшее изучение сетей, то начните с этого [репозитория](https://github.com/nleiva/kubernetes-networking-links)
