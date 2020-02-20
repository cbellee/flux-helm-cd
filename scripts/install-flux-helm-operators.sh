helm repo add fluxcd https://charts.fluxcd.io
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/flux-helm-release-crd.yaml

helm install flux fluxcd/flux --wait \
--namespace fluxcd \
--set git.url=git@github.com:cbellee/flux-helm-cd \
--set git.path="clusters/dev" \
--set git.label=dev \
--set additionalArgs={--sync-garbage-collection}


helm upgrade -i helm-operator fluxcd/helm-operator --wait \
--namespace fluxcd \
--set git.ssh.secretName=flux-git-deploy \
--set helm.versions=v3

export FLUX_FORWARD_NAMESPACE=fluxcd