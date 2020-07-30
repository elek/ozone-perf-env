kubectl get pods -o go-template --template  '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -l component=dd | xargs -n1 kubectl logs
