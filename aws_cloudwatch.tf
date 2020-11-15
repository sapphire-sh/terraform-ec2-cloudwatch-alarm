resource "aws_cloudwatch_metric_alarm" "disk_used_percent" {
  alarm_name          = "${var.name}-disk_used_percent"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  namespace           = "CWAgent"
  metric_name         = "disk_used_percent"
  period              = 300 # 5 minutes
  statistic           = "Average"
  threshold           = 80
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.main.arn]
  ok_actions          = [aws_sns_topic.main.arn]

  dimensions = {
    path         = "/"
    InstanceId   = aws_instance.main.id
    ImageId      = local.ami
    InstanceType = var.instance_type
    device       = "xvda1"
    fstype       = "ext4"
  }
}

resource "aws_cloudwatch_metric_alarm" "StatusCheckFailed" {
  alarm_name          = "${var.name}-StatusCheckFailed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  namespace           = "AWS/EC2"
  metric_name         = "StatusCheckFailed"
  period              = 300 # 5 minutes
  statistic           = "Average"
  threshold           = 0
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.main.arn]
  ok_actions          = [aws_sns_topic.main.arn]

  dimensions = {
    InstanceId = aws_instance.main.id
  }
}
