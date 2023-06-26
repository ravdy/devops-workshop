# Create a custom Helm chart

1. To create a helm chart template 
   ```sh 
   helm create ttrend
   ```

    by default, it contains 
    - values.yaml
    - templates
    - Charts.yaml
    - charts

2. Replace the template directory with the manifest files and package it
   ```sh
   helm package ttrend
   ```
3. Change the version number in the 
   ```sh 
   helm install ttrend ttrend-0.1.0.tgz
   ```

4. Create a jenkins job for the deployment 
   ```sh 
   stage(" Deploy ") {
          steps {
            script {
               echo '<--------------- Helm Deploy Started --------------->'
               sh 'helm install ttrend ttrend-0.1.0.tgz'
               echo '<--------------- Helm deploy Ends --------------->'
            }
          }
        }
   ```

5. To list installed helm deployments
   ```sh 
   helm list -a
   ```

Other useful commands
1. to change the default namespace to valaxy
   ```sh
   kubectl config set-context --current --namespace=valaxy
   ```