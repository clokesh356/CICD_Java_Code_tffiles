#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install java-openjdk11

wget -O /opt/apache-tomcat-9.0.68-windows-x64.zip
 https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68-windows-x64.zip

cd /opt
unzip apache-tomcat-9.0.67-windows-x64.zip
mv apache-tomcat-9.0.67 tomcat9
rm -f apache-tomcat-9.0.67-windows-x64.zip