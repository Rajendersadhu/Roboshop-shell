echo -e "\e[33mDisable Nodejs\e[0m"
dnf module disable nodejs -y
echo -e "\e[33mEnable Nodejs\e[0m"
dnf module enable nodejs:18 -y
echo -e "\e[33mInstall NodeJS\e[0m"
dnf install nodejs -y
echo -e "\e[33mAdd application User\e[0m"
useradd roboshop
echo -e "\e[33mLets setup an app directory\e[0m"
mkdir /app
echo -e "\e[33mDownload Application Content\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[33mExtract Application Content\e[0m"
unzip /tmp/user.zip
cd /app
echo -e "\e[33mDownload Nodejs \Dependencies\e[0m"
npm install
echo -e "\e[33mSetup SystemD User Service\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[33mLoad User service\e[0m"
systemctl daemon-reload
echo -e "\e[33mStart User service\e[0m"
systemctl enable user
systemctl restart user

