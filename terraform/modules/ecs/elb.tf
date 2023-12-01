resource "aws_lb" "go-rest-api-lb" {
  name               = var.aws_lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http_traffic.id]
  subnets = [
    "${aws_default_subnet.default_subnet_a.id}",
    "${aws_default_subnet.default_subnet_b.id}",
    "${aws_default_subnet.default_subnet_c.id}"
  ]

}

resource "aws_lb_target_group" "go-rest-api-tg" {
  name        = var.aws_lb_target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_default_vpc.default_vpc.id
  target_type = "ip"
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}


resource "aws_lb_listener" "go-rest-api-lb-listener" {
  load_balancer_arn = aws_lb.go-rest-api-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.go-rest-api-tg.arn
  }
}
