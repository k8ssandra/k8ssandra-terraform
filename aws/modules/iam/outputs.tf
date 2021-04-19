output "role_arn" {
  value = aws_iam_role.iam_role.arn
}

output "worker_role_arn" {
  value = aws_iam_role.worker_iam_role.arn
}

output "iam_instance_profile" {
  value = aws_iam_instance_profile.iam_instance_profile.id
}