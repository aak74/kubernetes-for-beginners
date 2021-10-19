# Ingress
[Документация](https://kubernetes.io/docs/concepts/services-networking/ingress/)

Ingress нужны для доступа к приложениям снаружи кластера по http(https). 

Ingress может обеспечить балансировку нагрузки, SSL termination и доступ по доменному имени.

Обеспечивает связь внешнего мира с приложением.

![ingress](images/ingress.png)

Для того чтобы была возможность создать ingress необходимо создать ingress controller. 
Ingress Controller-ы могут быть на базе различных ресурсов. 
Один из самых популярных nginx ingress controller

Весь список, который поддерживает Kubernetes в настоящий момент можно увидеть тут:

[https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)


## Демо
```shell script
kubectl -n ingress-nginx get po
kubectl -n ingress-nginx get ds
```

ingress controller устанавливается в кластере как DaemonSet
