#Worker
resource "aws_instance" "workers" {
  count         = var.worker_node_count
  ami           = var.ami_id
  instance_type = var.worker_instance_type
  iam_instance_profile = "${aws_iam_instance_profile.worker_profile.name}"
  subnet_id = "${element(module.vpc.private_subnets, count.index)}"
  key_name          =   aws_key_pair.k8_ssh.key_name
  security_groups = [aws_security_group.k8_nondes.id, aws_security_group.k8_workers.id]

  tags = {
    Name = format("Worker-%02d", count.index + 1)
  }
    lifecycle {
    ignore_changes = [disable_api_termination,ebs_optimized,hibernation,security_groups,
      credit_specification,network_interface,ephemeral_block_device]
  }
}

resource "aws_iam_role" "worker_role" {
  name = "worker_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      role = "worker"
  }
}

resource "aws_iam_instance_profile" "worker_profile" {
  name = "worker_profile"
  role = "${aws_iam_role.worker_role.name}"
}

resource "aws_iam_role_policy" "worker_policy" {
  name = "worker_policy"
  role = "${aws_iam_role.worker_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchGetImage"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}