#!/bin/bash
sudo yum install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
