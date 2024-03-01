echo -e "\e[33mDisable Mysql Default Version\e[0m"
dnf module disable mysql -y &>>/tmp/roboshop.log
echo -e "\e[33mSetup Mysql Repo File\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
echo -e "\e[33mInstall Mysql Community Server\e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log
echo -e "\e[33mStart Mysql Service\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld &>>/tmp/roboshop.log
echo -e "\e[33mChange Default Root Passwd\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
echo -e "\e[33mCheck the Mysql New Passwd\e[0m"
mysql -uroot -pRoboShop@1 &>>/tmp/roboshop.log

