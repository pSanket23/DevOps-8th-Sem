provider "aws" {
access_key	= "${var.aws_access_key_id}"
secret_key	= "${var.aws_secret_access_key}"
region     = "ap-south-1"
}



resource "aws_launch_configuration" "mylaunchconfig" {
name_prefix ="mylaunchconfig"
image_id ="ami-4fc58420"
instance_type = "t2.micro"
key_name ="terrformkeypair"
}


resource "aws_autoscaling_group" "myautoscalinggroup" {
  name                      = "myautoscalinggroup"
  availability_zones        = ["ap-south-1a"]
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "mylaunchconfig"
  
 }

resource "aws_s3_bucket" "my-palvit-test-bucket"{
  bucket = "my-palvit-test-bucket"
  acl    = "private"
}


resource "aws_iam_role" "S3-bucket-role" {
name = "s3-bucket-role"
assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": "s3:*",
           "Resource": "*"
       }
   ]
}
EOF
}

