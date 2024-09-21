resource "aws_iam_role" "s3_replication_role" {
  name = "s3_replication_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_replication_policy" {
  name = "s3_replication_policy"
  role = aws_iam_role.s3_replication_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging"
        ],
        Resource = "arn:aws:s3:::${var.source_bucket_name}/*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ],
        Resource = "arn:aws:s3:::${var.destination_bucket_name}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_replication_configuration" "source_replication" {
  bucket = var.source_bucket_name

  role = aws_iam_role.s3_replication_role.arn

  rule {
    id     = "replication-rule"
    status = "Enabled"

    filter {
      prefix = "dev/terraform.tfstate"
    }

    destination {
      bucket        = "arn:aws:s3:::${var.destination_bucket_name}"
      storage_class = "STANDARD"
    }

    delete_marker_replication {
      status = "Enabled"
    }
  }
}
