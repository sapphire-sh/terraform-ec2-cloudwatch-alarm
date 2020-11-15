resource "aws_sns_topic" "main" {
  name = var.name
}

resource "aws_sns_topic_subscription" "main" {
  topic_arn              = aws_sns_topic.main.arn
  protocol               = "https"
  endpoint               = "https://global.sns-api.chatbot.amazonaws.com"
  endpoint_auto_confirms = true
}
