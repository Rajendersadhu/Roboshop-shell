component=catalogue
color="\e[33m"
nocolor="\e[0m"

echo -e "${color}Disable Nodejs Previous Version${nocolor}"
dnf module disable nodejs -y &>>/tmp/roboshop.log
echo -e "${color}Enable Nodejs 18 Version${nocolor}"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log
echo -e "${color}Install NodeJS${nocolor}"
dnf install nodejs -y &>>/tmp/roboshop.log
echo -e "${color}Add application User${nocolor}"
useradd roboshop &>>/tmp/roboshop.log
echo -e "${color}Setup an App Directory${nocolor}"
mkdir /app &>>/tmp/roboshop.log
echo -e "${color}Download Application Content${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e "${color}Extract Application Content${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e "${color}Install Nodejs Dependencies${nocolor}"
npm install &>>/tmp/roboshop.log
echo -e "${color}Setup SystemD $component Service${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log
echo -e "${color}Load the Service${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "${color}Start $component Service${nocolor}"
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log
echo -e "${color}Copy Mongodb repo File${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
echo -e "${color}Install MongoDB Client${nocolor}"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "${color}Load Schema${nocolor}"
mongo --host mongodb-dev.sraji73.store </app/schema/$component.js &>>/tmp/roboshop.log

## test
