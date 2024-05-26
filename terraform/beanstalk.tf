resource "aws_elastic_beanstalk_application" "beanstalk_app" {
  name = "beanstalk_app_${var.enviroment_name}"
  description = "tf beanstalk app"

  appversion_lifecycle {
    service_role = aws_iam_role.beanstalk_ec2_role.arn
    max_count = 128
    delete_source_from_s3 = true
  }
}

resource "aws_elastic_beanstalk_environment" "beanstalk_environment" {
  name = "beanstalk_environment_${var.enviroment_name}"
  application = aws_elastic_beanstalk_application.beanstalk_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.8.1 running Docker"

  setting {
    name = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration"
    value = "t2.micro"
  }

  setting {
    name = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value = aws_iam_instance_profile.beanstalk_ec2_profile.name
  }

  setting {
    name = "MaxSize"
    namespace = "aws:autoscaling:asg"
    value = var.max_size
  }
  
}

resource "aws_elastic_beanstalk_application_version" "beanstalk_application_version" {
  name = "beanstalk_version_${var.enviroment_name}"  
  application = aws_elastic_beanstalk_application.beanstalk_app.name
  bucket = aws_s3_bucket.beanstalk_s3.id
  key = aws_s3_object.beanstalk_s3_object.id

  depends_on = [ 
    aws_s3_object.beanstalk_s3_object,
    aws_elastic_beanstalk_application.beanstalk_app,
    aws_elastic_beanstalk_environment.beanstalk_environment
  ]
}