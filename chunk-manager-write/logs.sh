kubectl get pods -o go-template --template  '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -l component=chunk-manager-write | xargs -n1 kubectl logs --tail=11
