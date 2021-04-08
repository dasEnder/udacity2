

variable "aws_region" {
    type = string 
}

variable "function_file" {
    type = string
}
variable "function_name" {
    type = string
}
variable "handler_name" {
    type = string
}
provider "aws" {
  region = var.aws_region
}
data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = var.function_file
    output_path   = "lambda_function.zip"
}

resource "aws_lambda_function" "udacity_function" {
  filename         = "lambda_function.zip"
  function_name    = var.function_file
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = var.handler_name
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
}
output "arn" {
  value  = aws_lambda_function.udactiy_lambda.arn
}
output "qualified_arn" {
  value       = aws_lambda_function.udactiy_lambda.qualified_arn
}
output "last_modified" {
  value       = aws_lambda_function.udactiy_lambda.last_modified
}






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
