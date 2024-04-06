output "mediawikiServers" {
  value = aws_instance.ec2wiki.*.public_ip
}