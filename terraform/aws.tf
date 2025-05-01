resource "aws_rolesanywhere_trust_anchor" "spiffe" {
  enabled = true
  name    = var.trust_anchor_name

  source {
    source_type = "CERTIFICATE_BUNDLE"

    source_data {
      x509_certificate_data = var.spiffe_ca_bundle
    }
  }
}

resource "aws_rolesanywhere_profile" "spiffe" {
  enabled   = true
  name      = var.profile_name
  role_arns = [aws_iam_role.spiffe.arn]
}

resource "aws_iam_role" "spiffe" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession",
          "sts:SetSourceIdentity"
        ]
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_rolesanywhere_trust_anchor.spiffe.arn
          }
          StringLike = {
            "aws:PrincipalTag/x509SAN/URI" : var.spiffe_san_matcher
          }
        }
        Effect = "Allow"
        Principal = {
          Service = "rolesanywhere.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy" "s3" {
  name = "${aws_iam_role.spiffe.name}-s3"
  role = aws_iam_role.spiffe.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          "arn:aws:s3:::${var.s3_bucket}",
          "arn:aws:s3:::${var.s3_bucket}/*"
        ]
      }
    ]
  })
}

output "profile_arn" {
  value = aws_rolesanywhere_profile.spiffe.arn
}

output "trust_anchor_arn" {
  value = aws_rolesanywhere_trust_anchor.spiffe.arn
}

output "role_arn" {
  value = aws_iam_role.spiffe.arn
}

output "aws_profile_config" {
  value = <<-EOT
  [profile default]
  credential_process = /aws-spiffe-workload-helper x509-credential-process x509-credential-process --profile-arn ${aws_rolesanywhere_profile.spiffe.arn} --trust-anchor-arn ${aws_rolesanywhere_trust_anchor.spiffe.arn} --role-arn ${aws_iam_role.spiffe.arn}
  EOT
}
