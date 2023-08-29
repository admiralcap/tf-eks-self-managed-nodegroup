# These rules are necessary to allow traffic between the cluster services
# (like CoreDNS) and the nodes. They allow ALL traffic.

resource "aws_vpc_security_group_ingress_rule" "eks-cluster-to-nodes-rule" {
    security_group_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
    referenced_security_group_id = aws_cloudformation_stack.cluster-nodes-stack.outputs["NodeSecurityGroup"]
    ip_protocol = -1
    description = "Allows all traffic from the cluster to the nodes"
    depends_on = [
        aws_cloudformation_stack.cluster-nodes-stack,
        aws_eks_cluster.eks-cluster
    ]
}
resource "aws_vpc_security_group_ingress_rule" "eks-nodes-to-cluster-rule" {
    security_group_id = aws_cloudformation_stack.cluster-nodes-stack.outputs["NodeSecurityGroup"]
    referenced_security_group_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
    ip_protocol = -1
    description = "Allows all traffic from the nodes to the cluster"
    depends_on = [
        aws_cloudformation_stack.cluster-nodes-stack,
        aws_eks_cluster.eks-cluster
    ]
}