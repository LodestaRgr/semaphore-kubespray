Deploy Kubernetes with Ansible Semaphore UI and Kubespray
------------
This project is based on the [Ansible Semaphore](https://github.com/ansible-semaphore/semaphore) and the [Kubespray](https://github.com/kubernetes-sigs/kubespray) projects. 
### Install semaphore-kubespray with Docker

Build and run the semaphore-kubespray docker image

```sh
cd semaphore
docker compose build
docker compose up -d
```

if "docker-compose build" or "docker compose build" does't work try to cd into the directory where your Dockerfile is and run the below command to build the image using docker build instead

```sh
docker build -t {image-name}:{version} .
e.g
docker build -t kubespray-semaphore:2.10.35 .
```

Login to the web-UI at https://localhost:3000 or https://<YOUR_SERVER_IP>:3000
