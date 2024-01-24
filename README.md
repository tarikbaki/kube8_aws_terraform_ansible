# Kubernetes cluster with Kubeadm on AWS using Terraform & Ansible.

### Tech Stack
Terraform, Ansible, Docker, cri-dockerd, kubeadm, Kubernetes, Ubuntu, AWS {VPC, EC2, NLB}

This repo contain the all required automation code for setting up Kubernetes cluster using kubeadm in AWS cloud environment.

#### Infrastructure Provisioning
Terraform for all the infrastructure provisioning automation.

#### Kubernetes Cluster Setup 
Ansible for all Server & Cluster configurations.

### Prerequisites
* You need to have your [AWS CLI configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html). 

## Usage

Clone this repo first then check the vars.tf for the AWS & Kubernetes cluster configurations. I already added default values for each variable. You can override any variable via command line or as a variable file.

Once you review the configuration you just need to apply the terraform code.

    terraform init
    terraform plan 
    terraform apply

Terraform apply will make sure it will provision all required infrastructure and setup kubernetes cluster on top of it.

> To ssh to the Bastion host you can find the "k8_ssh_key.pem" private key in your project folder. This will be dynamically created during infrastructure provisioning and added to the bastion host as well. Same key will be used to configure the ansible host and clients.

## Architecture
![image](https://github.com/tarikbaki/kube8_aws_terraform_ansible/assets/56624571/b3a08922-a680-475c-be67-20d95b72ff8d)


