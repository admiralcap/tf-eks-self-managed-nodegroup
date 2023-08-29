
resource "local_file" "aws-auth-cm" {
    filename = "./aws-auth-cm.yaml"
    file_permission = "0644"
    depends_on = [ aws_cloudformation_stack.cluster-nodes-stack ]
    content = <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_cloudformation_stack.cluster-nodes-stack.outputs["NodeInstanceRole"]}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
EOF


}

resource "local_file" "finish" {
    filename = "./finish.sh"
    file_permission = "0750"
    content = <<EOF
#!/bin/bash

set -e

# Configure kubectl to use the new cluster
aws eks update-kubeconfig \
    --region ${var.aws-region} \
    --name ${var.eks-cluster-name}

# apply the aws-auth ConfigMap
kubectl apply -f aws-auth-cm.yaml

echo Have fun with your cluster!

EOF    

}