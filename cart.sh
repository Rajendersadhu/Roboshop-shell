source common.sh
component=${component}

echo -e "${color}Disable Nodejs Default Version${nocolor}"
dnf module disable nodejs -y &>>${log_file}
echo -e "${color}Enable Nodejs 18th Version${nocolor}"
dnf module enable nodejs:18 -y &>>${log_file}
echo -e "${color}Install NodeJS${nocolor}"
dnf install nodejs -y &>>${log_file}
echo -e "${color}Add Application ${component} User\e[0"
useradd roboshop &>>${log_file}
echo -e "${color}Setup ${component} Application Directory\e[0"
mkdir ${app_path} &>>${log_file}
echo -e "${color}Download ${component} Application Content${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path} &>>${log_file}

echo -e "${color}Extract ${component} Application${nocolor}"
unzip /tmp/${component}.zip &>>${log_file}
cd ${app_path} &>>${log_file}
echo -e "${color}Download ${component} App Dependencies${nocolor}"
npm install &>>${log_file}
echo -e "${color}Setup SystemD ${component} Service${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
echo -e "${color}Load ${component} Service${nocolor}"
systemctl daemon-reload &>>${log_file}
echo -e "${color}Start ${component} Service${nocolor}"
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}

