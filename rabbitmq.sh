echo -e "${color}Configure Erlang Repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
echo -e "${color}Configure RabbitMQ Repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
echo -e "${color}Install RabbitMQ${nocolor}"
dnf install rabbitmq-server -y &>>$log_file
echo -e "${color}Start RabbitMQ Service${nocolor}"
systemctl enable rabbitmq-server &>>$log_file
systemctl restart rabbitmq-server &>>$log_file
echo -e "${color}Add RabbitMQ Application User${nocolor}"
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file


