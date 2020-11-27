resource "aws_backup_vault" "ec2_backup_vault" {
  name = "ec2_backup_vault"
  tags = {
    "Name" = "ec2_vault"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}

resource "aws_backup_plan" "ec2_backup_plan" {
  name = "ec2_backup_plan"

  rule {
    rule_name         = "ec2_backup_rule"
    target_vault_name = aws_backup_vault.ec2_backup_vault.name
    schedule          = "cron(0 12 * * ? *)"
    lifecycle {
      delete_after = 2 # delete after 2 days
    }
  }
  tags = {
    "Name" = "ec2_backup_plan"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}


resource "aws_iam_role" "ec2_backup_iam_role" {
  name               = "ec2_backup_iam_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
  tags = {
    "Name" = "ec2_iam_role"
    "Owner" = "Veronica Hajdeu"
    "Discipline" = "DevOps"
    "Purpose" = "Internship"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_backup_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.ec2_backup_iam_role.name
}


resource "aws_backup_selection" "example" {
  iam_role_arn = aws_iam_role.ec2_backup_iam_role.arn
  name         = "ec2_backup_selection"
  plan_id      = aws_backup_plan.ec2_backup_plan.id

  resources = [
    aws_instance.ec2_master.arn,
    aws_instance.ec2_slave.arn
  ]
}
