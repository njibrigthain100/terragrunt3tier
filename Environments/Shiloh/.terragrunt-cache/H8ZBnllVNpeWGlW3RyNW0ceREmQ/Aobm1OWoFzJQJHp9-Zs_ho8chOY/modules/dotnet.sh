#!/bin/bash
########################################
#### INSTALLING THE DOTNET WEBSITE ######
########################################
Webserver_path="market"
Url="https://www.free-css.com/assets/files/free-css-templates/download/page281/dotnet.zip"
Home_path="/var/www/html/$Webserver_path"

#Update and install apache
yum update -y
yum install -y httpd

#Create the directory
mkdir "$Home_path"
mkdir temp
cd temp

# Download and unzip the url
wget "$Url"

# Extract the filename from the URL
zipped_file=$(basename "$Url")

# Unzip the zipped file
unzip "$zipped_file"
# unzip dotnet.zip

Unzipped_directory=$(ls -d */)
mv "$Unzipped_directory"/* "$Home_path"
sed -i "s|DocumentRoot \"/var/www/html\"|DocumentRoot \"/var/www/html/\"|" /etc/httpd/conf/httpd.conf

#Start and enable apache 
systemctl enable httpd
systemctl restart httpd
