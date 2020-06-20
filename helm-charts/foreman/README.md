# foreman helm-chart

Create a SSH key and `known_hosts` file for the libvirt compute provider and save it as a Kubernetes secret:

```sh
kubectl create secret generic foreman-ssh --from-file=id_rsa.pub --from-file=id_rsa --from-file=known_hosts
```

Also create a certificate and key for the authentication against Foreman proxies:

```sh
kubectl create secret tls foreman-tls --cert=foreman.pem --key=foreman.key
```

If the certificate authority is untrusted, it's certificate also needs to be imported:

```sh
kubectl create secret generic foreman-ca --from-file=ca.crt=ca.crt
```

Finally change the `values.yaml` accordingly and deploy the Helm chart:

```
helm install --upgrade --name foreman .
```
