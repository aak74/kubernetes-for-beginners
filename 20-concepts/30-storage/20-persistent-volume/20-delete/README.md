# Удаление PersistentVolume
Теперь попробуем удалить PersistentVolume
```shell script
kubectl get pv

kubectl delete pv pv
```

Удаление зависнет в стадии `persistentvolume "pv" deleted`.

В другом окне терминала проверим в чем же дело.
 
```shell script
kubectl describe pv pv
kubectl describe pv pv | grep Status
```

Увидим:
```text
Status:          Terminating (lasts 3m2s)
```
В этом статусе PersistentVolume может висеть вечно.

Дело в том, что этот объект нельзя удалить из-за finalizers.

Finalizers - это специальные объекты, которые должны успешно выполниться для удаления родительского объекта.
```shell script
kubectl get pv pv -o yaml | grep -A1 finalizers
```

Результат:
```text
  finalizers:
  - kubernetes.io/pv-protection
```
Для того чтобы удалить PersistentVolume, нужно сначала удалить PersistentVolumeClaim.

```shell script
kubectl delete pvc pvc
```

Мы заняли еще одно окно терминала. А не один из объектов, пока не удален.
 
```shell script
kubectl get pvc pvc -o yaml | grep -A1 finalizers
```

Результат:
```text
  finalizers:
  - kubernetes.io/pvc-protection
```

Мы уже догадались, что есть еще один зависимый объект и это pod.
Только после удаления пода произойдет удаление всей цепочки.
```shell script
kubectl delete po pod

# Убедимся, что не осталось лишних объектов
kubectl get pod,pv,pvc
```

Стоит обратить внимание, что у объекта PersistentVolume нет принадлежности к конкретному namespace.
Поэтому при получении списка объектов PersistentVolume будут показаны все PersistentVolume во всех namespace.
