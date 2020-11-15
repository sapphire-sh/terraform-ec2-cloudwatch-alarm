resource "aws_ssm_parameter" "main" {
  name  = var.ssm_parameter_name
  type  = "String"
  value = file("./AmazonCloudWatch-linux.json")
}

# data "aws_ssm_document" "AWS_ConfigureAWSPackage" {
#   name = "AWS-ConfigureAWSPackage"
# }

# data "aws_ssm_document" "AmazonCloudWatch_ManageAgent" {
#   name = "AmazonCloudWatch-ManageAgent"
# }

# resource "aws_ssm_association" "AWS_ConfigureAWSPackage" {
#   name = data.aws_ssm_document.AWS_ConfigureAWSPackage.name

#   targets {
#     key    = "InstanceIds"
#     values = [aws_instance.main.id]
#   }

#   parameters = {
#     action = "Install"
#     name   = "AmazonCloudWatchAgent"
#   }

#   depends_on = [
#     aws_instance.main
#   ]
# }

# resource "time_sleep" "ssm_delay" {
#   depends_on = [aws_ssm_association.AWS_ConfigureAWSPackage]

#   create_duration = "60s"
# }

# resource "aws_ssm_association" "AmazonCloudWatch_ManageAgent" {
#   name = data.aws_ssm_document.AmazonCloudWatch_ManageAgent.name

#   targets {
#     key    = "InstanceIds"
#     values = [aws_instance.main.id]
#   }

#   parameters = {
#     action                        = "configure"
#     mode                          = "ec2"
#     optionalConfigurationSource   = "ssm"
#     optionalConfigurationLocation = var.ssm_parameter_name
#     optionalRestart               = "yes"
#   }

#   depends_on = [
#     aws_instance.main,
#     time_sleep.ssm_delay,
#   ]
# }
