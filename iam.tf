resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.test_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:CancelCommand",
                "ssm:GetCommandInvocation",
                "ssm:ListCommandInvocations",
                "ssm:ListCommands",
                "ssm:SendCommand",
                "ssm:GetAutomationExecution",
                "ssm:GetParameters",
                "ssm:StartAutomationExecution",
                "ssm:StopAutomationExecution",
                "ssm:ListTagsForResource",
                "ssm:GetCalendarState"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:UpdateServiceSetting",
                "ssm:GetServiceSetting"
            ],
            "Resource": [
                "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/*",
                "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstanceAttribute",
                "ec2:DescribeInstanceStatus",
                "ec2:DescribeInstances"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": [
                "arn:aws:lambda:*:*:function:SSM*",
                "arn:aws:lambda:*:*:function:*:SSM*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "states:DescribeExecution",
                "states:StartExecution"
            ],
            "Resource": [
                "arn:aws:states:*:*:stateMachine:SSM*",
                "arn:aws:states:*:*:execution:SSM*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "resource-groups:ListGroups",
                "resource-groups:ListGroupResources",
                "resource-groups:GetGroupQuery"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:DescribeStacks",
                "cloudformation:ListStackResources"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "tag:GetResources"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "config:SelectResourceConfig"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "compute-optimizer:GetEC2InstanceRecommendations",
                "compute-optimizer:GetEnrollmentStatus"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "support:DescribeTrustedAdvisorChecks",
                "support:DescribeTrustedAdvisorCheckSummaries",
                "support:DescribeTrustedAdvisorCheckResult",
                "support:DescribeCases"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "config:DescribeComplianceByConfigRule",
                "config:DescribeComplianceByResource",
                "config:DescribeRemediationConfigurations",
                "config:DescribeConfigurationRecorders"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:DescribeAlarms",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": [
                        "ssm.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": "organizations:DescribeOrganization",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudformation:ListStackSets",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:ListStackInstances",
                "cloudformation:DescribeStackSetOperation",
                "cloudformation:DeleteStackSet"
            ],
            "Resource": "arn:aws:cloudformation:*:*:stackset/AWS-QuickSetup-SSM*:*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudformation:DeleteStackInstances",
            "Resource": [
                "arn:aws:cloudformation:*:*:stackset/AWS-QuickSetup-SSM*:*",
                "arn:aws:cloudformation:*:*:stackset-target/AWS-QuickSetup-SSM*:*",
                "arn:aws:cloudformation:*:*:type/resource/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "events:PutRule",
                "events:PutTargets"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "events:ManagedBy": "ssm.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "events:RemoveTargets",
                "events:DeleteRule"
            ],
            "Resource": [
                "arn:aws:events:*:*:rule/SSMExplorerManagedRule"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "events:DescribeRule",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "securityhub:DescribeHub",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "test_role" {
  name = "ssm_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "ec2_profile-ssm" {
  name = "ec2_profile-ssm"
  role = aws_iam_role.test_role.name
}