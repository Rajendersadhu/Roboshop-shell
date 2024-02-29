echo -e "\e[33mDisable Nodejs Previous Version\e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
echo -e "\e[33mEnable Nodejs 18 Version\e[0m"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log
echo -e "\e[33mInstall NodeJS\e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[33mAdd application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33mSetup an App Directory\e[0m"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[33mDownload Application Content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e "\e[33mExtract Application Content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e "\e[33mInstall Nodejs Dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[33mSetup SystemD Catalogue Service\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e "\e[33mLoad the Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[33mStart Catalogue Service\e[0m"
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log
echo -e "\e[33mCopy Mongodb repo File\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
echo -e "\e[33mInstall MongoDB Client\e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[33mLoad Schema\e[0m"
mongo --host mongodb-dev.sraji73.store </app/schema/catalogue.js &>>/tmp/roboshop.log
