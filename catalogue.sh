source common.sh
component=catalogue

nodejs

echo -e "${color}Copy Mongodb repo File${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
echo -e "${color}Install MongoDB Client${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file
echo -e "${color}Load Schema${nocolor}"
mongo --host mongodb-dev.sraji73.store <${app_path}/schema/$component.js &>>$log_file

## test
