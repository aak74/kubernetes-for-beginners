# MicroK8s

[Официальный сайт](https://microk8s.io/)

Компания Canonical, известная своим Linux дистрибутивом Ubuntu, предлагает использовать простой инструмент microk8s.

Этот инструмент позволяет легко устанавливать и использовать Kubernetes.
Он хорошо зарекомендовал себя для локальной разработки и для запуска stage окружений.

## Установка 
Подробно установка освещена в [документации](https://microk8s.io/docs/getting-started).

```shell
# install
sudo snap install microk8s --classic --channel=1.25

# Join the group
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

# re-enter the session
su - $USER

# Check the status
microk8s status --wait-ready

# Access Kubernetes
microk8s kubectl get nodes

microk8s enable dns ingress
```

## Управление microk8s кластером с помощью kubectl
Удобно вместо связки `microk8s kubectl` использовать утилиту kubectl. Если она не установлена, то установите ее.

[Инструкция](../../../11-commands/00-kubectl-install.md) по установка kubectl.

Для работы kubectl нужен конфиг `~/.kube/config`.

Важно:
Предполагается, что этот конфиг пуст или отсутствует. При его наличии нужно его дополнить вручную. 

Файл для доступа находится в файле: `/var/snap/microk8s/current/credentials/kubelet.config` 
```shell
# copy file
cp /var/snap/microk8s/current/credentials/kubelet.config ~/.kube/config

# save config
microk8s config > ~/.kube/config

# Access Kubernetes
kubectl get nodes
```

На этом этапе все должно работать.

## Доступ к кластеру из-за пределов приватной сети
Вы можете столкнуться с проблемой вида:
`Unable to connect to the server: x509: certificate is valid for kubernetes, kubernetes.default, kubernetes.default.svc, kubernetes.default.svc.cluster, kubernetes.default.svc.cluster.local, not ...`
Это значит, что нужно выписать сертификат с учетом вашего адреса или имени домена.
Нужно следовать [инструкции](https://microk8s.io/docs/services-and-ports#heading--auth) или выполнить шаги описанные ниже.

### VPN
Хороший вариант для доступа к кластеру из-за пределов приватной сети - это доступ через VPN.
Тогда вам ничего менять не нужно. Вы и так находитесь внутри приватной сети.

### Через публичный адрес
Если сервер с microk8s имеет публичный адрес, то на него может не быть выписан сертификат.
В таком случае нужно этот IP адрес прописать в шаблоне `/var/snap/microk8s/current/certs/csr.conf.template`.

```shell
vim /var/snap/microk8s/current/certs/csr.conf.template

# edit section [ alt_names ]
# Add
# IP.4 = 123.45.67.89
# 123.45.67.89 = Your IP


# refresh certs
sudo microk8s refresh-certs --cert front-proxy-client.crt
```

После обновления сертификата кластер должен быть доступен.


### Доступ с удаленного компьютера
Сервер с microk8s может быть доступен через reverse proxy.
Адрес этого reverse proxy не будет указан в выписанном сертификате.
В таком случае нужно этот IP адрес или доменное имя прописать в шаблоне `/var/snap/microk8s/current/certs/csr.conf.template`.

```shell
vim /var/snap/microk8s/current/certs/csr.conf.template

# edit section [ alt_names ]
# Add
# DNS.6 = lb.example.com
# lb.example.com = your domain for reverse proxy
# OR
# IP.4 = 123.45.67.89
# 123.45.67.89 = Your IP


# refresh certs
sudo microk8s refresh-certs --cert front-proxy-client.crt
```

После обновления сертификата кластер должен быть доступен.
