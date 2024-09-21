# Target Group for Mumbai
resource "aws_lb_target_group" "app_tg_mumbai" {
  name     = "tg-mumbai"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0669c678723d01039"  

  health_check {
    path                = "/health"  
    interval            = 30         
    timeout             = 5          
    healthy_threshold   = 2          
    unhealthy_threshold = 2          
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment_mumbai" {
  target_group_arn = aws_lb_target_group.app_tg_mumbai.arn
  target_id        = aws_instance.app_mumbai.id
  port             = 80
}

resource "aws_lb_target_group" "app_tg_virginia" {
  provider = aws.us_east
  name     = "tg-virginia"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-03f23a5c643854a84"  

  health_check {
    path                = "/health"  
    interval            = 30 
    timeout             = 5        
    healthy_threshold   = 2          
    unhealthy_threshold = 2        
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment_virginia" {
  provider         = aws.us_east
  target_group_arn = aws_lb_target_group.app_tg_virginia.arn
  target_id        = aws_instance.app_virginia.id
  port             = 80
}
