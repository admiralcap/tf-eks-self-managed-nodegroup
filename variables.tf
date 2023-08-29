variable "aws-region" {
    type = string
    default = "us-east-1"
}

variable "vpc-stack-name" {
    type = string
    default = "your-eks-vpc-stack"
}

variable "aws-keypair-name" {
    type = string
    default = "aws-keypair"
}

variable "eks-cluster-name" {
    type = string
    default = "your-cluster"
}

variable "cluster-nodes-stack-name" {
    type = string
    default = "your-cluster-nodes-stack"
}

variable "node-group-basic-parameters" {
    type = map
    default = {
        NodeGroupName = "your-node-group"
        NodeAutoScalingGroupMinSize = 1
        NodeAutoScalingGroupDesiredCapacity = 3
        NodeAutoScalingGroupMaxSize = 30
        NodeInstanceType = "t3.micro"
    }
}

