resource "aws_cloudformation_stack" "eks-vpc-stack" {
    name = var.vpc-stack-name
    template_url = "https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml"
}

data "aws_subnets" "eks-vpc-subnets-private" {
  filter {
    name   = "vpc-id"
    values = [aws_cloudformation_stack.eks-vpc-stack.outputs["VpcId"]]
  }
  filter {
    name = "tag:Name"
    values = [
        # NOTE: These are the names given by the cloudformation template
        # prefixed with the CF stack name
        "${var.vpc-stack-name}-PrivateSubnet01",
        "${var.vpc-stack-name}-PrivateSubnet02"
    ]

  }
  depends_on = [ aws_cloudformation_stack.eks-vpc-stack ]
  
}