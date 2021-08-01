# Быстрый тур
- [A quick tour of qbec](https://qbec.io/userguide/tour/)
- [Download](https://github.com/splunk/qbec/releases)

```shell script
# Completion
qbec completion | sudo tee /etc/bash_completion.d/qbec
```
## Создание конфигурации
```shell script
qbec init 10-demo --with-example
```
При создании конфигурации будет выбран кластер из текущего контекста файла `~/.kube.config`.  
