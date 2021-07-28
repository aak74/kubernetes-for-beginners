# Package manager

## Материалы
- [helm repo](https://helm.sh/docs/helm/helm_repo/)
- [Поиск чартов](https://artifacthub.io/)
- [Установка на примере Prometheus alertmanager](https://artifacthub.io/packages/helm/prometheus-community/alertmanager)

```shell script
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo list
helm repo update
helm search repo alertmanager

helm install [RELEASE_NAME] prometheus-community/alertmanager
helm uninstall [RELEASE_NAME]
helm upgrade [RELEASE_NAME] [CHART] --install

helm pull prometheus-community/alertmanager
```
