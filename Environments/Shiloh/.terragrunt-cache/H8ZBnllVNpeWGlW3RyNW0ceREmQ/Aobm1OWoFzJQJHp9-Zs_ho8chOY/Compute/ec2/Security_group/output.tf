output "customer-webserver-security-group" {
  value = [aws_security_group.customer-webserver-security-group.id]
}

output "customer-appserver-security-group" {
  value = [aws_security_group.customer-appserver-security-group.id]
}

output "customer-ssh-security-group" {
  value = [aws_security_group.customer-SSH-Bastion-sg.id]
}

output "customer-rdp-security-group" {
  value = [aws_security_group.customer-RDP-Bastion-sg.id]
}