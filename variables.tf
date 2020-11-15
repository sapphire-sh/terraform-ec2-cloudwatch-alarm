variable "region" {
  default = "ap-northeast-2"
}

variable "ami" {
  type = map(string)

  // ubuntu 20.04 LTS
  # https://cloud-images.ubuntu.com/locator/ec2/ 참고
  default = {
    ap-northeast-2 = "ami-007b7745d0725de95"
    us-east-1      = "ami-0c43b23f011ba5061"
    ap-northeast-1 = "ami-0aa7c595324d25274"
    us-west-2      = "ami-06e54d05255faf8f6"
  }
}

variable "name" {
  default = "terraform-ec2-cloudwatch-alarm"
}

variable "instance_type" {
  default = "t2.small"
}

variable "ssm_parameter_name" {
  default = "AmazonCloudWatch-linux"
}

resource "random_string" "password" {
  length  = 32
  special = false
}
