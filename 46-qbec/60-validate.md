# Валидация
Для уверенности в правильном развертывании необходимо проверять конфигурацию на корректность. Такую проверку можно запускать вручную или включить в свой CI pipeline.

```shell script
# Проверка конфигурации на корректность 
qbec validate default

# todo раскрыть подробнее
qbec validate stage
# Можно в списке компоненте использовать несуществующую переменную и тогда будет видно ошибку 

```
