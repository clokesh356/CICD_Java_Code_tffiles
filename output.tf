output "cicdip" {
  value = aws_instance.cicd.public_ip
}

output "cicdpubdns" {
  value = aws_instance.cicd.public_dns

}
output "apacheip" {
  value = aws_instance.apache.public_ip
}

output "apachepubdns" {
  value = aws_instance.apache.public_dns

}

output "tomcatip" {
  value = aws_instance.tomcat.public_ip
  
}

output "tomcatprivateip" {
  value = aws_instance.tomcat.private_ip
  
}
output "dockerpublicip" {
  value = aws_instance.docker.public_ip
  
}

output "dockerprivateip" {
  value = aws_instance.docker.private_ip
  
}