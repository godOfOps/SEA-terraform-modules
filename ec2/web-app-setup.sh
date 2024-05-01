#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "Hello World from $(hostname)" > /var/www/html/index.html
#ToDo
# Configure logging for httpd
# Pull Web app from Github Repo