# Выводы
Инструмент заслуживает внимание. 
Позволяет:
- очень гибко настраивать конфигурации ваших приложений;
- валидировать конфигурацию;
- сравнивать переменные для различных окружений;
- сравнивать полученные шаблоны для различных окружений;
- развертывать приложение в разные кластеры и убедится в результате развертывания.

Минусы:
- маленькое community;
- довольно мало материалов по использованию.

Один из альтернативных продуктов `ksonnet` закрыли.
По `kubecfg` документации очень мало. Отправляют на сайт посвященный jsonnet.
Есть ощущение, что задачи которые решаются этим инструментом не очень актуальны. 
В связи с этим велики риски закрытия проекта. 

Как альтернативу имеет смысл рассматривать подход [GitOps](https://habr.com/ru/company/flant/blog/526102/) и инструменты, которые представлены на этом рынке:
- [werf](https://ru.werf.io/)
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)
- [Flux](https://fluxcd.io/)
