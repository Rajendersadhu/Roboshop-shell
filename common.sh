color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"
user_id=$(id -u)
if [ $user_id -ne 0 ]; then
  echo script should be running with sudo
  exit 1
fi



stat_check(){
  if [ $1 -eq 0 ]; then
    echo SUCCESS
     else
     echo FAILURE
     exit 1
  fi
}


app_presetup() {
   echo -e "${color}Add application User${nocolor}"
   id roboshop &>>$log_file
   if [ $? -eq 1 ]; then
   useradd roboshop &>>$log_file
   fi
 stat_check $?

   echo -e "${color}Lets setup an app directory${nocolor}"
   rm -rf ${app_path} &>>$log_file
   mkdir ${app_path} &>>$log_file
  stat_check $?

   echo -e "${color}Download the application${nocolor}"
   curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
   stat_check $?

    echo -e "${color}Extract $component App${nocolor}"
    cd ${app_path} &>>$log_file
    unzip /tmp/$component.zip &>>$log_file
     stat_check $?
}


systemd_setup() {
    echo -e "${color}Setup SystemD $component Service${nocolor}"
    cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file

      stat_check $?

    echo -e "${color}Start the service${nocolor}"
    systemctl daemon-reload &>>$log_file
    systemctl enable $component &>>$log_file
    systemctl restart $component &>>$log_file

    stat_check $?

}


nodejs() {
  echo -e "${color}Disable Nodejs Previous Version${nocolor}"
  dnf module disable nodejs -y &>>$log_file
  stat_check $?
  echo -e "${color}Enable Nodejs 18 Version${nocolor}"
  dnf module enable nodejs:18 -y &>>$log_file
  stat_check $?
  echo -e "${color}Install NodeJS${nocolor}"
  dnf install nodejs -y &>>$log_file
   stat_check $?
  
  app_presetup



  echo -e "${color}Install Nodejs Dependencies${nocolor}"
  npm install &>>$log_file
   stat_check $?

 systemd_setup

}


mongo_schema_setup() {
  echo -e "${color}Copy Mongodb repo File${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
   stat_check $?
  echo -e "${color}Install MongoDB Client${nocolor}"
  dnf install mongodb-org-shell -y &>>$log_file
   stat_check $?
  echo -e "${color}Load Schema${nocolor}"
  mongo --host mongodb-dev.sraji73.store <${app_path}/schema/$component.js &>>$log_file
   stat_check $?
}


mysql_schema_setup() {
  echo -e "${color}Install Mysql Client${nocolor}"
  dnf install mysql -y &>>$log_file
   stat_check $?

  echo -e "${color}load the schema${nocolor}"
  mysql -h mysql-dev.sraji73.store -uroot -p${mysql_root_password} </app/schema/${component}.sql &>>$log_file
   stat_check $?
}



maven() {
  echo -e "${color}Install Maven${nocolor}"
  dnf install maven -y &>>$log_file
   stat_check $?
  
  app_presetup
  

  echo -e "${color}Download Application Dependencies${nocolor}"
  mvn clean package &>>$log_file
  mv target/$component-1.0.jar $component.jar &>>$log_file
   stat_check $?

  mysql_schema_setup


 systemd_setup
}

python() {
  echo -e "${color}Install Python${nocolor}"
  dnf install python36 gcc python3-devel -y &>>$log_file

  stat_check $?

  app_presetup

  echo -e "${color}Download Application Dependencies${nocolor}"
  cd /app &>>$log_file
  pip3.6 install -r requirements.txt &>>$log_file

  stat_check $?


  systemd_setup


}



