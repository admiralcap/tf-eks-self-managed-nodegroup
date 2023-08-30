resource "aws_cloudformation_stack" "cluster-nodes-stack" {
    name = var.cluster-nodes-stack-name
    template_url = "https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2022-12-23/amazon-eks-nodegroup.yaml"

    parameters = merge(
        var.node-group-basic-parameters,
        {
            ClusterName = var.eks-cluster-name
            KeyName = var.aws-keypair-name
            ClusterControlPlaneSecurityGroup = aws_cloudformation_stack.eks-vpc-stack.outputs["SecurityGroups"]
            VpcId = aws_cloudformation_stack.eks-vpc-stack.outputs["VpcId"]
        
            # The type in the template is "List" which is actually a comma separated
            # string list for cloudformation not a terraform list.
            Subnets = join(",", data.aws_subnets.eks-vpc-subnets-private.ids)
        }
    )

    capabilities = [
        "CAPABILITY_IAM"
    ]

    depends_on = [ 
        aws_cloudformation_stack.eks-vpc-stack,
        aws_key_pair.aws-keypair,
        data.aws_subnets.eks-vpc-subnets-private,
        aws_eks_cluster.eks-cluster
    ]
}
