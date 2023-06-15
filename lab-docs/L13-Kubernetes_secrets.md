## Integrate Jfrog with Kubernetes cluster
  
1. Create a dedicated user to use for a docker login   
     user menu --> new user  
     `user name`: jfrogcred  
     `email address`: valaxytech@gmail.com  
     `password`: <passwrod>  

2. To pull an image from jfrog at the docker level, we should log into jfrog using username and password   
```sh 
 docker login https://valaxy01.jfrog.io
``` 
1. Kubernetes uses credentials as part of the deployment process to pull the image; for this, we must create a secret at the Kubernetes level   
```sh 
   kubectl create secret docker-registry jfrogcred \
   --docker-server=valaxy01.jfrog.io \
   --docker-username=kubernetes_admin \
   --docker-password=Admin@123 \
   --docker-email=valaxytech@gmail.com \
   -n valaxy
``` 

  alternatively, you can also run the below command to create secret file   
  ```sh 
   kubectl create secret generic jfrogcred --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson -n valaxy -o yaml > secret.yaml
  ```

  anotherway is, genarate encode value for ~/.docker/config.json file 
  ```sh 
   cat ~/.docker/config.json | base64 -w0
   ```
   
`Note:` For more refer to [Kuberentes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)  
Make sure secret value name `regcred` is updated in the deployment file.  

  `copy auth value to encode`
  cat ~/.docker/config.json | base64 -w0
  `use above command output in the secret`
```
