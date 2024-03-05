component=catalogue
color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

echo -e "${color}Disable Nodejs Previous Version${nocolor}"
dnf module disable nodejs -y &>>$log_file
echo -e "${color}Enable Nodejs 18 Version${nocolor}"
dnf module enable nodejs:18 -y &>>$log_file
echo -e "${color}Install NodeJS${nocolor}"
dnf install nodejs -y &>>$log_file
echo -e "${color}Add application User${nocolor}"
useradd roboshop &>>$log_file
echo -e "${color}Setup an App Directory${nocolor}"
mkdir ${app_path} &>>$log_file
echo -e "${color}Download Application Content${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
cd ${app_path} &>>$log_file
echo -e "${color}Extract Application Content${nocolor}"
unzip /tmp/$component.zip &>>$log_file
cd ${app_path} &>>$log_file
echo -e "${color}Install Nodejs Dependencies${nocolor}"
npm install &>>$log_file
echo -e "${color}Setup SystemD $component Service${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
echo -e "${color}Load the Service${nocolor}"
systemctl daemon-reload &>>$log_file
echo -e "${color}Start $component Service${nocolor}"
systemctl enable $component &>>$log_file
systemctl restart $component &>>$log_file
echo -e "${color}Copy Mongodb repo File${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
echo -e "${color}Install MongoDB Client${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file
echo -e "${color}Load Schema${nocolor}"
mongo --host mongodb-dev.sraji73.store <${app_path}/schema/$component.js &>>$log_file

## test
