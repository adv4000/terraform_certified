#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`


cat <<EOF > /var/www/html/index.html
<html>
<h2>Built by Power of <font color="red">Terraform</font></h2><br>

WebServer with Static IP! <br>

<br>
PrivateIP: $MYIP

<p>
<font color="blue">Version 4.0</font>
</html>
EOF

service httpd start
chkconfig httpd on
