## Publish jar file onto Jfrog Artifactory
1. Create Artifactory account  
2. Generate an access token  with username  (username must be your email id)
3. Add username and password under jenkins credentials   
4. Install Artifactory plugin  
5. Update Jenkinsfile with jar publish stage   
    ```sh 
         def registry = 'https://valaxy01.jfrog.io'
             stage("Jar Publish") {
            steps {
                script {
                        echo '<--------------- Jar Publish Started --------------->'
                         def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artifactory_token"
                         def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                         def uploadSpec = """{
                              "files": [
                                {
                                  "pattern": "jarstaging/(*)",
                                  "target": "libs-release-local/{1}",
                                  "flat": "false",
                                  "props" : "${properties}",
                                  "exclusions": [ "*.sha1", "*.md5"]
                                }
                             ]
                         }"""
                         def buildInfo = server.upload(uploadSpec)
                         buildInfo.env.collect()
                         server.publishBuildInfo(buildInfo)
                         echo '<--------------- Jar Publish Ended --------------->'  
                
                }
            }   
        }   
    ```

Check-point: 
Ensure below are update
1. your jfrog account details in place of `https://valaxy01.jfrog.io` in the defination of registry `def registry = 'https://valaxy01.jfrog.io'`
2. Credentials id in the place of `jfrogforjenkins` in the  `def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artifactory_token"`
3. Maven repository name in the place of `libs-release-local` in the `"target": "ttrend-libs-release-local/{1}",`

