resource "aws_lb" "this" {
  name               = "vault-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_lb_target_group" "vault" {
  name     = "vault-tg"
  port     = 8200
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/v1/sys/health"
    port                = "8200"
    protocol            = "HTTP"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200,429" # 200 = active, 429 = standby. This allows standby nodes to receive traffic for redirection or UI.
  }

  tags = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vault.arn
  }
}

resource "aws_lb_target_group_attachment" "vault" {
  count = length(var.vault_instance_ids)

  target_group_arn = aws_lb_target_group.vault.arn
  target_id        = var.vault_instance_ids[count.index]
  port             = 8200
}
