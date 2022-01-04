# Разное

## Набор полезных команд для работы с Yandex.Cloud

```shell
yc config profile list

yc compute instance create --help
yc compute image list --folder-id standard-images

yc vpc subnet list
yc compute disk-type list

yc compute instance create \
    --name el-instance \
    --zone ru-central1-c \
    --network-interface subnet-name=default,nat-ip-version=ipv4 \
    --memory 4 \
    --cores 4 \
    --create-boot-disk image-folder-id=standard-images,image-family=centos-7,type=network-ssd,size=65 \
    --ssh-key ~/.ssh/id_rsa.pub

yc compute instance list
yc compute instance delete --name=el-instance
```
