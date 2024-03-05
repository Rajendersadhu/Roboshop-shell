

echo -e "\e[33mDisable Nodejs Default Version\e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
echo -e "\e[33mEnable Nodejs 18th Version\e[0m"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log
echo -e "\e[33mInstall NodeJS\e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[33mAdd Application Cart User\e[0"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33mSetup Cart Application Directory\e[0"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[33mDownload Cart Application Content\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33mExtract Cart Application\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e "\e[33mDownload Cart App Dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[33mSetup SystemD Cart Service\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
echo -e "\e[33mLoad Cart Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[33mStart Cart Service\e[0m"
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log

