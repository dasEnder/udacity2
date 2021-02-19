provider "aws" {
  region = "${var.aws_region}"
}


data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "greet_lambda.py"
    output_path   = "lambda_function.zip"
}

resource "aws_lambda_function" "udactiy_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "udactiy_lambda"
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = "greet_lambda.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.8"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}

EOF



# {
#   "Version": "2012-10-17",
#   "Id": "default",
#   "Statement": [
#     {
#       "Sid": "InvokePermissionsForCWL0834b758c532ac26f5478b865509ef67",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "logs.amazonaws.com"
#       },
#       "Action": "lambda:InvokeFunction",
#       "Resource": "arn:aws:lambda:us-east-1:918025571920:function:udactiy_lambda",
#       "Condition": {
#         "StringEquals": {
#           "AWS:SourceAccount": "918025571920"
#         },
#         "ArnLike": {
#           "AWS:SourceArn": "arn:aws:logs:us-east-1:918025571920:log-group:/aws/lambda/udactiy_lambda:*"
#         }
#       }
#     }
#   ]
# }
}