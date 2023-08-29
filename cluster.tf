resource "aws_eks_cluster" "eks-cluster" {
    name = var.eks-cluster-name
    role_arn = aws_iam_role.AmazonEKSClusterRole.arn

    vpc_config {
        subnet_ids = split(
            ",", 
            aws_cloudformation_stack.eks-vpc-stack.outputs["SubnetIds"]
            )
    }

    depends_on = [
        aws_cloudformation_stack.eks-vpc-stack,
        aws_iam_role.AmazonEKSClusterRole,
        aws_iam_role_policy_attachment.AmazonEKSClusterPolicy-attachment
     ]

}