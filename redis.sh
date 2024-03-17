
source common.sh

echo -e "${color}Install Redis Repo File${nocolor}"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log_file
stat_check $?

echo -e "${color}Enable Redis Package${nocolor}"
dnf module enable redis:remi-6.2 -y &>>$log_file
stat_check $?

echo -e "${color}Install Redis${nocolor}"
dnf install redis -y &>>$log_file
stat_check $?

echo -e "${color}Update Listen Address${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>$log_file
stat_check $?

echo -e "${color}Start & Enable Redis Service${nocolor} "
systemctl enable redis &>>$log_file
systemctl restart redis &>>$log_file
stat_check $?




