resource "aws_iam_role" "AmazonEKSClusterRole" {
    name = "AmazonEKSClusterRole"

    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": {
              "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
          }
        ]
    })

    depends_on = [ aws_cloudformation_stack.eks-vpc-stack ]
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy-attachment" {
    role = "AmazonEKSClusterRole"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    depends_on = [ aws_iam_role.AmazonEKSClusterRole ]
}