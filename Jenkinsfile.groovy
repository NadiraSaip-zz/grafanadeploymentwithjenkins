#!/usr/bin/env groovy
package com.lib
import groovy.json.JsonSlurper

node('master') {
  #!/usr/bin/env groovy
package com.lib
import groovy.json.JsonSlurper

node('master') {
 properties([parameters([
    booleanParam(defaultValue: false, description: 'If you press this parameter it will apply all the changes', name: 'terraformApply'), 
    booleanParam(defaultValue: false, description: 'if you press this parameter it will destroy everything', name: 'terraformDestroy'), 
    string(defaultValue: 'default_password', description: 'Please use password for the grafana user', name: 'Password', trim: true),
    properties([parameters([string(defaultValue: 'test', description: 'please provide namespace', name: 'namespace', trim: true)
    ]
    )])
    checkout scm
    stage('Generate Vars') {
        def file = new File("${WORKSPACE}/grafanadeploymentwithjenkins/grafana.tfvars")
        file.write """
        password              =  "${password}"
        namespace             = "${namespace}"

        """
      }
    stage("Terraform init") {
      dir("${workspace}/grafanadeploymentwithjenkins/") {
        sh "terraform init"
      }
    }
    stage('Terraform Apply/Plan') {
      if (params.terraformApply) {
        dir("${WORKSPACE}/grafanadeploymentwithjenkins/") {
          echo "##### Terraform Applying the Changes ####"
          sh "terraform apply  --auto-approve  -var-file=grafana.tfvars"
        }
    } else {
        dir("${WORKSPACE}/grafanadeploymentwithjenkins/") {
          echo "##### Terraform Plan (Check) the Changes ####"
          sh "terraform plan -var-file=grafana.tfvars"
        }
      } 
    }
}
    stage('Terraform Destoy') {
      if (params.terraformDestroy) {
        dir("${WORKSPACE}/grafanadeploymentwithjenkins/") {
          echo "##### Terraform Destroying the Changes ####"
          sh "terraform destroy  --auto-approve  -var-file=grafana.tfvars"
        }
      } 
    }
}

