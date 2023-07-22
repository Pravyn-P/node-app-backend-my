# task definition, service
resource "aws_ecs_task_definition" "api" {
  family = "${local.tags.Name}"
  execution_role_arn = aws_iam_role.api_role_task_execution.arn
  task_role_arn = aws_iam_role.api_role_task.arn
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 1024
  memory = 2048
  container_definitions = <<TASK_DEFINITION
  [
    {
        "cpu": 10,
        "memory": 128,
        "essential": true,
        "image": "617480992998.dkr.ecr.ap-south-1.amazonaws.com/node-app-backend:latest",
        "name": "api-ecs",
        "portMappings": [
            {
                "containerport": 3000
            }
        ],
        
        "environment": ${jsonencode(local.env_vars)},
        "secrets": ${jsonencode(local.application_secrets)}
    }
  ]
  TASK_DEFINITION
}