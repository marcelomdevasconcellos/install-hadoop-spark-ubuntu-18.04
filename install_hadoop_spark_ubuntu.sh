#!/bin/bash

echo "Do you wish to install Java 8.0.252.hs-adpt ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
            echo "Installing Java 8.0.252.hs-adpt ..."
            # https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h

            java -version
            sudo apt autoremove
            sudo apt install curl -y
            sudo apt install unzip
            sudo apt install zip
            curl -s "https://get.sdkman.io" | bash
            echo "source ~/.sdkman/bin/sdkman-init.sh" >> ~/.bashrc
            source ~/.bashrc
            sdk install java 8.0.252.hs-adpt
            echo "export JAVA_HOME=~/.sdkman/candidates/java/8.0.252.hs-adpt/" >> ~/.bashrc
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to install Hadoop 3.2.1 ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
            echo "Installing Hadoop 3.2.1 ..."
            # https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h
            
            rm *.tar.gz
            wget https://mirrors.whoishostingthis.com/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
            sudo tar -xvf hadoop-3.2.1.tar.gz -C /opt/
            rm hadoop-3.2.1.tar.gz
            sudo mv /opt/hadoop-3.2.1 /opt/hadoop && sudo chown $USER:$USER -R /opt/hadoop
            echo "export HADOOP_INSTALL=/opt/hadoop" >> ~/.bashrc
            echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
            echo "export HADOOP_COMMON_HOME=/opt/hadoop" >> ~/.bashrc
            echo "export HADOOP_HDFS_HOME=/opt/hadoop" >> ~/.bashrc
            echo "export HADOOP_YARN_HOME=/opt/hadoop" >> ~/.bashrc
            echo "export YARN_HOME=/opt/hadoop" >> ~/.bashrc
            echo "export HADOOP_COMMON_LIB_NATIVE_DIR=/opt/hadoop/lib/native" >> ~/.bashrc
            echo "export PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin" >> ~/.bashrc
            echo "export JAVA_HOME=~/.sdkman/candidates/java/8.0.252.hs-adpt" >> /opt/hadoop/etc/hadoop/hadoop-env.sh
            source ~/.bashrc
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to install Spark 3.0.0 ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
            echo "Installing Spark 3.0.0 ..."
            # https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h

            rm *.tar.gz
            wget http://mirror.nbtelecom.com.br/apache/spark/spark-3.0.0-preview2/spark-3.0.0-preview2-bin-hadoop3.2.tgz
            sudo tar -xvf spark-3.0.0-preview2-bin-hadoop3.2.tgz -C /opt/
            rm spark-3.0.0-preview2-bin-hadoop3.2.tgz
            sudo mv /opt/spark-3.0.0-preview2-bin-hadoop3.2 /opt/spark && sudo chown $USER:$USER -R spark

            echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
            echo "export PATH=$PATH:$SPARK_HOME/bin" >> ~/.bashrc
            echo "export HDFS_NAMENODE_USER=$USER" >> ~/.bashrc
            echo "export HDFS_DATANODE_USER=$USER" >> ~/.bashrc
            echo "export HDFS_SECONDARYNAMENODE_USER=$USER" >> ~/.bashrc
            echo "export YARN_RESOURCEMANAGER_USER=$USER" >> ~/.bashrc
            echo "export YARN_NODEMANAGER_USER=$USER" >> ~/.bashrc

            echo "Installing Python ..."
            # https://towardsdatascience.com/installing-pyspark-with-java-8-on-ubuntu-18-04-6a9dea915b5b

            echo "export PYTHONPATH=/usr/bin/python3" >> ~/.bashrc
            echo "export PYSPARK_PYTHON=python3" >> ~/.bashrc
            # echo "export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH" >> ~/.bashrc
            # echo "export PYSPARK_DRIVER_PYTHON="jupyter"" >> ~/.bashrc
            # echo "export PYSPARK_DRIVER_PYTHON_OPTS="notebook"" >> ~/.bashrc
            # apt install python3-pip
            # pip3 install jupyter
            source ~/.bashrc
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to configure Hadoop ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
			echo "Configuring Hadoop ..."
			# https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h

			cp hadoop-config/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml 
			cp hadoop-config/hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml
			sudo mkdir -p /opt/hadoop_tmp/hdfs/datanode
			sudo mkdir -p /opt/hadoop_tmp/hdfs/namenode
			sudo chown $USER:$USER -R /opt/hadoop_tmp
			cp hadoop-config/mapred-site.xml /opt/hadoop/etc/hadoop/mapred-site.xml 
			cp hadoop-config/yarn-site.xml /opt/hadoop/etc/hadoop/yarn-site.xml
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to install OpenSSH ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
			echo "Installing OpenSSH ..."
			# https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h

			which sshd
			sudo apt install openssh-server
			sudo systemctl status ssh
            source ~/.bashrc
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to create KeyGen ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
			echo "Creating KeyGen ..."
			# https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h

			ssh-keygen
			cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to format and boot HDFS ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
			echo "Formatting and Booting HDFS ..."
			# https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h

			hdfs namenode -format -force
			start-dfs.sh && start-yarn.sh
			hdfs dfs -mkdir /bigdata
			hdfs dfs -ls /
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to install Mongodb ?"
select yn in Yes No
do
    case $yn in
        Yes ) 
            echo "Installing Mongodb ..."
            # https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-18-04-pt

            sudo apt update
            sudo apt install -y mongodb
            sudo systemctl status mongodb
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to install FTP?"
select yn in Yes No
do
    case $yn in
        Yes ) 
            echo "Installing FTP ..."
            # https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-18-04

            sudo apt update
            sudo apt install vsftpd
            sudo ufw status
            sudo ufw allow 20/tcp
            sudo ufw allow 21/tcp
            sudo ufw allow 990/tcp
            sudo ufw allow 40000:50000/tcp
            sudo ufw status
            sudo adduser bigdata
            sudo mkdir /home/bigdata/ftp
            sudo chown nobody:nogroup /home/bigdata/ftp
            sudo chmod a-w /home/bigdata/ftp
            sudo ls -la /home/bigdata/ftp
            sudo mkdir /home/bigdata/ftp/files
            sudo chown bigdata:bigdata /home/bigdata/ftp/files
            sudo ls -la /home/bigdata/ftp
            echo "vsftpd test file" | sudo tee /home/bigdata/ftp/files/test.txt
            echo "anonymous_enable=NO" >> /etc/vsftpd.conf
            echo "local_enable=YES" >> /etc/vsftpd.conf
            echo "write_enable=YES" >> /etc/vsftpd.conf
            echo "chroot_local_user=YES" >> /etc/vsftpd.conf
            echo "user_sub_token=$USER" >> /etc/vsftpd.conf
            echo "local_root=/home/$USER/ftp" >> /etc/vsftpd.conf
            echo "pasv_min_port=40000" >> /etc/vsftpd.conf
            echo "pasv_max_port=50000" >> /etc/vsftpd.conf
            echo "userlist_enable=YES" >> /etc/vsftpd.conf
            echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf
            echo "userlist_deny=NO" >> /etc/vsftpd.conf
            echo "bigdata" | sudo tee -a /etc/vsftpd.userlist
            cat /etc/vsftpd.userlist
            sudo systemctl restart vsftpd
            break;;
        No ) 
            break;;
    esac
done


echo "Do you wish to install mysql-server?"
select yn in Yes No
do
    case $yn in
        Yes ) 
            echo "Installing mysql-server ..."
            # https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-18-04

            sudo apt update
            sudo apt install mysql-server
            sudo mysql_secure_installation
            sudo mysqladmin -p -u $USER version
            systemctl status mysql.service
            break;;
        No ) 
            break;;
    esac
done


echo ""
echo ""
echo "Hadoop and Spark come with built-in web-based monitors that you can access by going to http://localhost:8088"
echo "...and http://localhost:9870 in your browser:"
echo ""
echo "If you want to start the HDFS, you can run the commands:"
echo "$ start-dfs.sh && start-yarn.sh"
echo ""
echo "You can check that HDFS is running correctly with the command jps:"
echo "$ jps"
echo ""
echo "For open the Spark shell"
echo "$ spark-shell"
echo ""
echo "If you want to stop the HDFS, you can run the commands:"
echo "$ stop-dfs.sh && stop-yarn.sh"
echo ""
echo ""

