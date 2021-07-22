# Сценарий

## Демонстрация

```shell script
kubectl apply -f pvc-access-mode.yaml
kubectl get pvc
# pvc Pending 
kubectl describe pvc pvc-access-mode
# Waiting 

kubectl exec pod-pvc -- dd if=/dev/zero of=/static/2.txt bs=1G count=2

kubectl exec pod-int-volumes -c nginx -- sh -c "echo '42' > /static/42.txt"
kubectl exec pod-int-volumes -c nginx -- ls -la /static
kubectl exec pod-int-volumes -c busybox -- ls -la /tmp/cache
kubectl exec pod-int-volumes -c busybox -- touch /tmp/cache/43.56

find /var/lib/kubelet/pods/ -name 42.*
kubectl delete po pod-int-volumes
ls -la /var/lib/kubelet/pods/

kubectl apply -f /home/kopylov/k8s/pod-int-volumes.yaml
kubectl exec pod-int-volumes -c nginx -- ls -la /static

kubectl delete pv pv-capacity

minikube addons list
minikube addons enable storage-provisioner

kubectl apply -f /home/kopylov/k8s/pod-pvc.yaml
kubectl get po
kubectl describe po pod-pvc

kubectl apply -f /home/kopylov/k8s/pvc-capacity.yaml

kubectl get pv,pvc

kubectl delete pv pv-capacity-default
kubectl delete pvc pvc-capacity-default
kubectl delete pod pod-capacity-defaultpvc


kubectl --context prod -n default get pvc
kubectl --context prod -n default get sts

shuf -i 0-9000 > number.out
```
