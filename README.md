# tf-eks-self-managed-nodegroup


This is some basic terraform code to launch an EKS cluster and a self managed node group.  

It uses cloudformation templates for most of it, but managed with terraform.  

Basically I followed the instructions from these two articles and put them into terraform:  

[Getting started with Amazon EKS – AWS Management Console and AWS CLI](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html)

**NOTE: Only steps 1 & 2 from the above guide, then pick up in this next guide for creating the node group.**

[Launching self-managed Amazon Linux nodes](https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html)

## Why?
There are better ways to do this, but I did it this way specifically to address
some limitations of the [KodeKloud AWS SandBox
Playground](https://kodekloud.com/playgrounds/playground-aws).  
Most notably, the lack of permissions to create managed node groups and lack of some iam
permissions like "iam:CreateOpenIDConnectProvider" that prevent using some
terraform modules.

## Prerequisites

- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)  
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)  
  Configured with an access key: `$ aws configure`  
- [kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)  

## Usage

### Clone the repo:
```
$ git clone https://github.com/admiralcap/tf-eks-self-managed-nodegroup.git
$ cd tf-eks-self-managed-nodegroup
```

### Initialize, plan and apply


`$ terraform init`  
`$ terraform plan -out=thegrandplan`  

***This will take a LONG time.. go grab some coffee.***  
`$ terraform apply "thegrandplan"`  

### Finishing touches

Take a look at the script `finish.sh` then run it:  

`$ ./finish.sh`

### Have fun playing with your cluster!

It will take a minute to spin up your nodes. Check the status with:  

`$ kubectl get nodes --watch`

