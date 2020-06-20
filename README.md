# docker-foreman

Docker image and helm chart for deploying Foreman server on Kubernetes

Docker hub: [hub.docker.com/r/lu1as/foreman](https://hub.docker.com/r/lu1as/foreman)

## Deploy

Checkout helm chart at `helm-charts/foreman`.

## Develop

`foreman-installer` can be used to create a foreman-installer Docker image for testing purpoes.

`foreman-server` builds the Foreman server Docker image. The image is designed to be deployed with the Helm chart, so the `docker-compose.yml` is only for testing and debugging it. The VNC console will not work, because it requires a Nginx sidecar for forwarding the ports properly.
