source common.sh

echo -e "${color}Disable Mysql Default Version${nocolor}"
dnf module disable mysql -y &>>$log_file
stat_check $?

echo -e "${color}Setup Mysql Repo File${nocolor}"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check $?

echo -e "${color}Install Mysql Community Server${nocolor}"
dnf install mysql-community-server -y &>>$log_file
stat_check $?

echo -e "${color}Start Mysql Service${nocolor}"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check $?

echo -e "${color}Change Default Root Passwd${nocolor}"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
stat_check $?

echo -e "${color}Check the Mysql New Passwd${nocolor}"
mysql -uroot -pRoboShop@1 &>>$log_file
stat_check $?
