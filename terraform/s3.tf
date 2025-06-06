resource "aws_s3_bucket" "example" {
  bucket = "zobeir-s3-bucket"
  tags = {
    Name        = "Zobeir-s3-terraform"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.example.id
  policy = jsonencode(
    {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" :  [
          aws_s3_bucket.example.arn,
          "${aws_s3_bucket.example.arn}/*"
        ]
      }
    ]
  }
  )
}

