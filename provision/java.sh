#!/bin/bash

echo 'Install Java'


sudo add-apt-repository -y ppa:webupd8team/java &> /dev/null
sudo apt-get update &> /dev/null
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java7-installer &> /dev/null
sudo update-java-alternatives -s java-7-oracle &> /dev/null
sudo apt-get install -y oracle-java7-set-default &> /dev/null

sudo apt-get install -y tomcat7 tomcat7-admin ant &> /dev/null

sudo update-rc.d tomcat7 defaults 80 01

sudo sed -i "s#<Connector port=\"8080\" protocol=\"HTTP/1.1\"#<Connector port=\"80\" protocol=\"HTTP/1.1\"#" /etc/tomcat7/server.xml
sudo sed -i "s/#AUTHBIND=no/AUTHBIND=yes/" /etc/default/tomcat7
sudo sed -i "s/#JAVA_HOME=\/usr\/lib\/jvm\/openjdk-6-jdk/JAVA_HOME=\/usr\/lib\/jvm\/java-7-oracle/" /etc/default/tomcat7


sudo sed -i "/<tomcat-users>/a \
    <user username=\"admin\" password=\"agora\" roles=\"manager-gui,admin-gui\"\/>" /etc/tomcat7/tomcat-users.xml


echo 'Install Oracle Server'
pushd /vms/provision/oracle/
if [ ! -f ojdbc7.jar ]; then
    echo 'Download ojdbc7.jar and save it on provision folder'
    exit -1
fi
popd
sudo cp /vms/provision/oracle/ojdbc7.jar /usr/share/tomcat7/lib/
sudo chmod 777 /usr/share/tomcat7/lib/ojdbc7.jar

sudo rm -Rf /var/lib/tomcat7/webapps/ROOT/

sudo chmod -R 777 /var/log/tomcat7/
sudo chown -R vagrant:vagrant /var/log/tomcat7/

sudo service tomcat7 restart &> /dev/null