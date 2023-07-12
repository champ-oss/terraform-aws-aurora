resource "aws_secretsmanager_secret_version" "this" {
  count = var.enable_glue_connection ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = random_password.password.result
}

resource "aws_secretsmanager_secret" "this" {
  count = var.enable_glue_connection ? 1 : 0
  name = "${var.name}-${random_string.identifier.result}"
}