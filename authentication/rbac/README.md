# RBAC
Role-based access control (RBAC) - управление доступом основанное на ролях.
Это метод регулирующий доступ к компьютерным или сетевым ресурсам основанный на ролях отдельных пользователей в вашей организации. 

Для настройки таких доступов в Kubernetes необходимо создать следующие артефакты:
- Пользователь user, или service account (ServiceAccount)
- Role, ClusterRole
- RoleBinding, ClusterRoleBinding

- [Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/)
- [RBAC with Kubernetes in Minikube](https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b)
## Создание пользователя

 Создайте пользователя на мастере, а затем перейдите в его домашнюю директорию для выполнения остальных шагов:

useradd jean && cd /home/jean

Создайте закрытый ключ:

openssl genrsa -out jean.key 2048

Создайте запрос на подпись сертификата (certificate signing request, CSR). CN — имя пользователя, O — группа. Можно устанавливать разрешения по группам. Это упростит работу, если, например, у вас много пользователей с одинаковыми полномочиями:

# Без группы
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean"

# С группой под названием $group
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean/O=$group"

# Если пользователь входит в несколько групп
openssl req -new -key jean.key \
-out jean.csr \
-subj "/CN=jean/O=$group1/O=$group2/O=$group3"

Подпишите CSR в Kubernetes CA. Мы должны использовать сертификат CA и ключ, которые обычно находятся в /etc/kubernetes/pki. Сертификат будет действителен в течение 500 дней:

openssl x509 -req -in jean.csr \
-CA /etc/kubernetes/pki/ca.crt \
-CAkey /etc/kubernetes/pki/ca.key \
-CAcreateserial \
-out jean.crt -days 500
