helm repo add fluxcd https://charts.fluxcd.io
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/flux-helm-release-crd.yaml

helm upgrade -i flux fluxcd/flux --wait \
--namespace fluxcd \
--set git.url=git@github.com:cbellee/flux-helm-cd \
--set git.path="clusters/common\,clusters/aks-3acf67" \
--set git.label=aks-3acf67 \
--set additionalArgs={--sync-garbage-collection}


helm upgrade -i helm-operator fluxcd/helm-operator --wait \
--namespace fluxcd \
--set git.ssh.secretName=flux-git-deploy \
--set helm.versions=v3

export FLUX_FORWARD_NAMESPACE=fluxcd