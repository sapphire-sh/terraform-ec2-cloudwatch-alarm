resource "aws_key_pair" "main" {
  key_name   = "deployer-key"
  public_key = file("id_rsa.pub")
}

resource "aws_iam_instance_profile" "main" {
  name = var.name
  role = aws_iam_role.main.name
}

resource "aws_instance" "main" {
  ami                         = local.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.main.name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb",
      "sudo dpkg -i -E ./amazon-cloudwatch-agent.deb",
      "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:${var.ssm_parameter_name}",
      "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status",
    ]
  }

  tags = {
    Name = var.name
  }

  depends_on = [
    aws_ssm_parameter.main
  ]
}
