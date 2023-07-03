## Integrate Jfrog with Kubernetes cluster
  
1. Create a dedicated user to use for a docker login   
     user menu --> new user  
     `user name`: jfrogcred  
     `email address`: logintoaws@gmail.com  
     `password`: <passwrod>  

2. To pull an image from jfrog at the docker level, we should log into jfrog using username and password   
```sh 
 docker login https://valaxy05.jfrog.io
```

3. genarate encode value for ~/.docker/config.json file 
  ```sh 
   cat ~/.docker/config.json | base64 -w0
   ```
   
`Note:` For more refer to [Kuberentes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)  
Make sure secret value name `regcred` is updated in the deployment file.  

  `copy auth value to encode`
  cat ~/.docker/config.json | base64 -w0
  `use above command output in the secret`
```
