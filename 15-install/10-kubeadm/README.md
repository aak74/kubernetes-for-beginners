# Установка Kubernetes
[Документация](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)

## Требования к ресурсам нод
### Требования к ресурсам control plane node
- CPU — от 2 ядер
- ОЗУ — от 2 ГБ
- Диск — от 50 ГБ

### Требования к ресурсам worker node
- CPU — от 1 ядра
- ОЗУ — от 1 ГБ
- Диск — от 100 ГБ

## Установка
Упрощенная схема установки

![Схема](./images/10-kubeadm-install.png)

Инструкции по установке:
- [Установка control plane](./10-kubeadm-control-plane.md)
- [Установка worker node](./20-kubeadm-worker-node.md)
