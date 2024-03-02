echo -e "\e[33mInstall GoLang\e[0m"
dnf install golang -y &>>/tmp/roboshop.log
echo -e "\e[33mAdd application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33mLets setup an app directory\e[0m"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[33mDownload the application\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e "\e[33mExtract Application\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
echo -e "\e[33mDownload Dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log
echo -e "\e[33mSetup SystemD Payment Service\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log
echo -e "\e[33mLoad the service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[33mStart the service\e[0m"
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log


