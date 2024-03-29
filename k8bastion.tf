#Bastion
resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = "true"
  security_groups = [aws_security_group.allow_ssh.id]
  key_name          =   aws_key_pair.k8_ssh.key_name
  ##https://github.com/hashicorp/terraform/issues/30134
  user_data = <<-EOF
                #!bin/bash
                echo "PubkeyAcceptedKeyTypes=+ssh-rsa" >> /etc/ssh/sshd_config.d/10-insecure-rsa-keysig.conf
                systemctl reload sshd
                echo "${tls_private_key.ssh.private_key_pem}" >> /home/ubuntu/.ssh/id_rsa
                chown ubuntu /home/ubuntu/.ssh/id_rsa
                chgrp ubuntu /home/ubuntu/.ssh/id_rsa
                chmod 600   /home/ubuntu/.ssh/id_rsa
                echo "starting ansible install"
                apt-add-repository ppa:ansible/ansible -y
                apt update
                apt install ansible -y
                EOF

  tags = {
    Name = "Bastion"
  }
    lifecycle {
    ignore_changes = [disable_api_termination,ebs_optimized,hibernation,security_groups,
      credit_specification,network_interface,ephemeral_block_device]
  }
}
