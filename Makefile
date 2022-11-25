all:
	curl mwlb.mwlabs.net
	kubectl get pods -n mwlb -o wide

apply:
	kubectl apply -f namespace.yaml
	kubectl apply -n mwlb -f webserver.yaml

