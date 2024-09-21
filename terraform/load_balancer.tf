resource "aws_lb" "app_lb_mumbai" {
  name               = "app-lb-mumbai"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.mumbai_security_group_id]
  subnets            = ["subnet-057cc99e1737e20d0", "subnet-0d97b689ddb0eefe7"]

  enable_deletion_protection = false

  tags = {
    Name = "App-LB-Mumbai"
  }
}

resource "aws_lb" "app_lb_virginia" {
  provider           = aws.us_east
  name               = "app-lb-virginia"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.virginia_security_group_id]
  subnets            = ["subnet-0ffd86eb1548dbce6", "subnet-02b747c9397d9250c"]

  enable_deletion_protection = false

  tags = {
    Name = "App-LB-Virginia"
  }
}

resource "aws_lb_listener" "app_listener_mumbai" {
  load_balancer_arn = aws_lb.app_lb_mumbai.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg_mumbai.arn
  }
}

resource "aws_lb_listener" "app_listener_virginia" {
  provider          = aws.us_east
  load_balancer_arn = aws_lb.app_lb_virginia.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg_virginia.arn
  }
}
