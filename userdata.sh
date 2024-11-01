!#/bin/bash
echo "Este es un mensaje" > ~/msg.txt
yum update -y
yum install httpd -y
systemctl enable httpd 
systemctl start httpd