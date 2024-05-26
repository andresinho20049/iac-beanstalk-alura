resource "aws_iam_role" "beanstalk_ec2_role" {
  name = "beanstalk_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "beanstalk_ec2_role_1"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}


resource "aws_iam_role_policy" "beanstalk_ec2_role_policy" {
  name = "beanstalk_ec2_role_policy"
  role = aws_iam_role.beanstalk_ec2_role.id

  policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "beanstalk_ec2_role_policy_1",
                "Effect": "Allow",
                "Action": [
                    "cloudwatch:PutMetricData",
                    "ds:CreateComputer",
                    "ds:DescribeDirectories",
                    "ec2:DescribeInstanceStatus",
                    "logs:*",
                    "ssm:*",
                    "ec2messages:*",
                    "ecr:GetAuthorizationToken",
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:GetDownloadUrlForLayer",
                    "ecr:GetRepositoryPolicy",
                    "ecr:DescribeRepositories",
                    "ecr:ListImages",
                    "ecr:DescribeImages",
                    "ecr:BatchGetImage",
                    "s3:*"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]
    })
}

resource "aws_iam_instance_profile" "beanstalk_ec2_profile" {
  name = "beanstalk_ec2_profile"
  role = aws_iam_role.beanstalk_ec2_role.name
}