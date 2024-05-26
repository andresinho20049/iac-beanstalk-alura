resource "aws_s3_bucket" "beanstalk_s3" {
  bucket = "andresinho20049_alura_beanstalk_${var.enviroment_name}"
}

resource "aws_s3_object" "beanstalk_s3_object" {
  depends_on = [
    aws_s3_bucket.beanstalk_s3
  ]

  bucket = aws_s3_bucket.beanstalk_s3.bucket
  key    = "dockerrun_${var.enviroment_name}.zip"
  source = "dockerrun_${var.enviroment_name}.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("dockerrun_${var.enviroment_name}.zip")
}
