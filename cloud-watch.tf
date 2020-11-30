resource "aws_cloudwatch_event_rule" "ami_backup" {
  name                = "AMI-backup"
  description         = "Create AMI backups using lambda function ${var.lambda_function_name}"
  schedule_expression = "cron(0 12 * * ? *)"
    tags = {
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}

resource "aws_cloudwatch_event_target" "check_foo_every_one_minute" {
  rule      = aws_cloudwatch_event_rule.ami_backup.name
  target_id = "lambda"
  arn       = aws_lambda_function.create_ami_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_ami_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ami_backup.arn
}
