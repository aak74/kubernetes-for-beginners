# Бесконечный статус terminating

## Pods
[stackoverflow][https://stackoverflow.com/a/55080289/1979624]
```shell script
# Остановка одного пода
kubectl delete pod demo --grace-period=0 --force

# Остановка нескольких подов
NAMESPACE=default for p in $(kubectl get pods -n $NAMESPACE| grep Terminating | awk '{print $1}'); do kubectl delete pod $p --grace-period=0 --force -n $NAMESPACE;done
```

## PersistentVolumeClaim & PersistentVolume
[stackoverflow](https://stackoverflow.com/questions/51358856/kubernetes-cant-delete-persistentvolumeclaim-pvc)
```shell script
kubectl patch pvc $PVC_NAME -p '{"metadata":{"finalizers": []}}' --type=merge
```

[github](https://github.com/kubernetes/kubernetes/issues/69697#issuecomment-448541618)
```shell script
kubectl patch pvc db-pv-claim -p '{"metadata":{"finalizers":null}}'
kubectl patch pod db-74755f6698-8td72 -p '{"metadata":{"finalizers":null}}'
```

[github](https://github.com/kubernetes/kubernetes/issues/77258#issuecomment-514543465)
```shell script
kubectl get pv | tail -n+2 | awk '{print $1}' | xargs -I{} kubectl patch pv {} -p '{"metadata":{"finalizers": null}}'
```
