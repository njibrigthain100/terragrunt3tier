locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service      = var.Service
    Owner        = var.Owner
    Environment  = var.Environment
    Tier         = var.Tier
    Build-Method = var.Build-Method
    CostCenter   = var.CostCenter
    Complaince   = var.Compliance

  }
}
#########################SERVER AMIS IMPORT###############################
# Get latest Amazon Linux 2 AMI for the web servers
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Get latest Windows Server 2019 AMI
data "aws_ami" "windows-2019" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
}

# Get latest SQL server AMI
data "aws_ami" "amznlnx2-SQL" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-x86_64-SQL_2017_Standard*"]
  }
}
#########################NETWORKING RESOURCE IMPORT#########################
data "aws_vpc" "customer_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-VPC"]
  }
}

data "aws_subnet" "customer_private_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-Private-Subnet-1"]
  }
}

data "aws_subnet" "customer_private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-Private-Subnet-2"]
  }
}

data "aws_subnet" "customer_public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-Public-Subnet-1"]
  }
}

data "aws_subnet" "customer_public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-Public-Subnet-2"]
  }
}

####################SECURITY GROUP IMPORT####################################

data "aws_security_group" "webserver-security-group" {
  filter {
    name = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-WebServer-security_group"]
  }
}

data "aws_security_group" "appserver-security-group" {
  filter {
    name = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-Appserver-security-group"]
  }
}

data "aws_security_group" "ssh-bastion" {
  filter {
    name = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-SSH-Bastion-Security-group"]
  }
}

data "aws_security_group" "rdp-bastion" {
  filter {
    name = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-RDP-Bastion-Security-group"]
  }
}

data "aws_security_group" "db-security-group" {
  filter {
    name = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-db-security-group"]
  }
}

data "aws_security_group" "lb-security-group" {
  filter {
    name = "tag:Name"
    values = ["${var.Owner}-${var.Environment}-lb-security-group"]
  }
}


########################SSH BASTION CREATION##################################
resource "aws_instance" "customer-ssh-bastion" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.bastion-instance-type 
  associate_public_ip_address = "true"
  key_name = var.keyname
  subnet_id = data.aws_subnet.customer_public_subnet_1.id
  security_groups = [data.aws_security_group.ssh-bastion.id]
  iam_instance_profile = var.iam_instance_profile

 tags = merge(local.common_tags,
    {
      "Name" = "${var.Owner}-${var.Environment}-ssh-bastion"
    }
  )
}

#########################RDP BASTION CREATION####################################
resource "aws_instance" "customer-rdp-bastion" {
  ami = data.aws_ami.windows-2019.id
  instance_type = var.bastion-instance-type 
  associate_public_ip_address = "true"
  key_name = var.keyname
  subnet_id = data.aws_subnet.customer_public_subnet_1.id
  security_groups = [data.aws_security_group.rdp-bastion.id]
  iam_instance_profile = var.iam_instance_profile

 tags = merge(local.common_tags,
    {
      "Name" = "${var.Owner}-${var.Environment}-rdp-bastion"
    }
  )
}

#########################APPSERVER CREATION########################################
resource "aws_instance" "customer-appserver" {
  ami = data.aws_ami.windows-2019.id
  instance_type = var.instance_server_type 
  user_data = "${file("iis.ps1")}"
  key_name = var.keyname
  subnet_id = data.aws_subnet.customer_private_subnet_1.id
  security_groups = [data.aws_security_group.appserver-security-group.id]
  count = length(var.appserver-names)
  iam_instance_profile = var.iam_instance_profile
  #root disk
  root_block_device {
    volume_size = var.windows_volume_size
    volume_type = var.windows_volume_type
    encrypted = true 
    delete_on_termination = true 
  }

  tags = merge(local.common_tags,
    {
      Name = element(var.appserver-names, count.index)
    }
  )
}


#########################WEBSERVER CREATION########################################
resource "aws_instance" "customer-webserver-cobsine" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_server_type 
  associate_public_ip_address = "true"
  user_data = "${file("cobsine.sh")}"
  key_name = var.keyname
  subnet_id = data.aws_subnet.customer_public_subnet_1.id
  security_groups = [data.aws_security_group.webserver-security-group.id]
  iam_instance_profile = var.iam_instance_profile

  tags = merge(local.common_tags,
    {
      Name = "${var.Owner}-${var.Environment}-${var.webserver-name-cobsine}-w-01"
    }
  )
}
resource "aws_instance" "customer-webserver-dotnet" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_server_type 
  associate_public_ip_address = "true"
  user_data = "${file("dotnet.sh")}"
  key_name = var.keyname
  subnet_id = data.aws_subnet.customer_public_subnet_2.id
  security_groups = [data.aws_security_group.webserver-security-group.id]
  iam_instance_profile = var.iam_instance_profile

  tags = merge(local.common_tags,
    {
      Name = "${var.Owner}-${var.Environment}-${var.webserver-name-dotnet}-w-01"
    }
  )
}

######################DBSERVER CREATION######################################
resource "aws_instance" "customer-dbserver" {
  ami = data.aws_ami.amznlnx2-SQL.id
  instance_type = var.sql_instance_type
  key_name = var.keyname
  subnet_id = data.aws_subnet.customer_private_subnet_1.id
  security_groups = [data.aws_security_group.db-security-group.id]
  count = length(var.dbserver-names)
  iam_instance_profile = var.iam_instance_profile

  tags = merge(local.common_tags,
    {
      Name = element(var.dbserver-names, count.index)
    }
  )
}

###############CREATING THE WEBSERVER LOAD BALANCER#####################
resource "aws_lb" "customer-webserver-lb" {
  name               = var.load-balancer-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb-security-group.id]
  subnets            = [data.aws_subnet.customer_public_subnet_1.id, data.aws_subnet.customer_public_subnet_2.id]

 tags = merge(local.common_tags,
    {
      "Name" = "${var.Owner}-${var.Environment}-webserver-lb"
    }
  )
}

# resource "aws_lb_target_group" "customer-alb-tg" {
#   name     = var.target_group_name
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = data.aws_vpc.customer_vpc.id
#   health_check {
#       healthy_threshold   = var.health_check["healthy_threshold"]
#       interval            = var.health_check["interval"]
#       unhealthy_threshold = var.health_check["unhealthy_threshold"]
#       timeout             = var.health_check["timeout"]
#       path                = var.health_check["path"]
#       port                = var.health_check["port"]
#   }
#  tags = merge(local.common_tags,
#     {
#       "Name" = "${var.Owner}-${var.Environment}-webserver-tg"
#     }
#   )
# }


resource "aws_lb_target_group" "customer-cobsine-tg" {
  name     = var.cobsine-target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.customer_vpc.id
  health_check {
      healthy_threshold   = var.health_check["healthy_threshold"]
      interval            = var.health_check["interval"]
      unhealthy_threshold = var.health_check["unhealthy_threshold"]
      timeout             = var.health_check["timeout"]
      path                = var.health_check["path"]
      port                = var.health_check["port"]
  }
 tags = merge(local.common_tags,
    {
      "Name" = "${var.Owner}-${var.Environment}-cobsine-tg"
    }
  )
}

resource "aws_lb_target_group" "customer-dotnet-tg" {
  name     = var.dotnet-target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.customer_vpc.id
  health_check {
      healthy_threshold   = var.health_check["healthy_threshold"]
      interval            = var.health_check["interval"]
      unhealthy_threshold = var.health_check["unhealthy_threshold"]
      timeout             = var.health_check["timeout"]
      path                = var.health_check["path"]
      port                = var.health_check["port"]
  }
 tags = merge(local.common_tags,
    {
      "Name" = "${var.Owner}-${var.Environment}-dotnet-tg"
    }
  )
}

resource "aws_lb_target_group_attachment" "customer-cobsine-tg-attachment1" {
  target_group_arn = aws_lb_target_group.customer-cobsine-tg.arn
  target_id        = aws_instance.customer-webserver-cobsine.id 
  port             = 80
}

resource "aws_lb_target_group_attachment" "customer-dotnet-tg-attachment1" {
  target_group_arn = aws_lb_target_group.customer-dotnet-tg.arn
  target_id        = aws_instance.customer-webserver-dotnet.id 
  port             = 80
}


resource "aws_lb_listener" "webserver" {
  load_balancer_arn = aws_lb.customer-webserver-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code = "200"
      message_body = "OK"
    }
  }
}


# resource "aws_lb_listener_rule" "lb_listener_http" {
#  listener_arn = aws_lb_listener.front_end.arn 
#  priority = 100 

#  action{
#    type = "forward"
#    target_group_arn = aws_lb_target_group.customer-alb-tg.arn
#  }

#   condition {
#     path_pattern {
#       values = ["/static/*"]
#     }
#   }
# }

resource "aws_lb_listener_rule" "cobsine_listener_http" {
 listener_arn = aws_lb_listener.webserver.arn 
 priority = 100 

 action{
   type = "forward"
   target_group_arn = aws_lb_target_group.customer-cobsine-tg.arn
 }

  condition {
    path_pattern {
      values = ["/home*"]
    }
  }
}

resource "aws_lb_listener_rule" "dotnet_listener_http" {
 listener_arn = aws_lb_listener.webserver.arn 
 priority = 101 

 action{
   type = "forward"
   target_group_arn = aws_lb_target_group.customer-dotnet-tg.arn
 }

  condition {
    path_pattern {
      values = ["/market*"]
    }
  }
}


resource "aws_route53_record" "customer-webserver-dns-record" {
  zone_id = var.parent_zone_id
  name    = "app.myafriquefashion.com"
  type    = "A"
  # ttl     = "60"
  # records = [aws_lb.customer-webserver-lb.dns_name]
    alias {
    name                   = aws_lb.customer-webserver-lb.dns_name
    zone_id                = aws_lb.customer-webserver-lb.zone_id
    evaluate_target_health = true
  }
}
