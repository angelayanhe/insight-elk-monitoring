#!/bin/bash

# Update package manager
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt update

# Install basic environment
sudo apt --yes --force-yes install ssh rsync openjdk-8-jdk scala python-dev python-pip python-numpy python-scipy python-pandas gfortran git supervisor ruby bc

# Install sbt for scala
wget https://dl.bintray.com/sbt/debian/sbt-0.13.7.deb -P ~/Downloads
sudo dpkg -i ~/Downloads/sbt-*

# Install maven3
sudo apt install maven

# Set java
sudo update-java-alternatives -s java-1.8.0-openjdk-amd64

# Install boto
sudo pip install nose boto

# Set JAVA_HOME
if ! grep "export JAVA_HOME" ~/.profile; then
  echo -e "\nexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" | cat >> ~/.profile
  echo -e "export PATH=\$PATH:\$JAVA_HOME/bin" | cat >> ~/.profile
fi
	
# Path to S3 bucket for downloading Hadoop and Spark
S3_BUCKET=https://s3-us-west-2.amazonaws.com/insight-tech

# Set code versions
HADOOP_VER=2.7.6
SPARK_VER=2.3.1
SPARK_HADOOP_VER=2.7

# Set file paths
HOME_DIR=/usr/local
HADOOP_URL=${S3_BUCKET}/hadoop/hadoop-$HADOOP_VER.tar.gz
SPARK_URL=${S3_BUCKET}/spark/spark-$SPARK_VER-bin-hadoop$SPARK_HADOOP_VER.tgz

# Download and install Hadoop
curl -sL $HADOOP_URL | gunzip | sudo tar xv -C /usr/local >> ~/peg_log.txt
sudo mv /usr/local/*hadoop* /usr/local/hadoop
echo "export HADOOP_HOME=/usr/local/hadoop" | cat >> ~/.profile
echo -e "export PATH=\$PATH:\$HADOOP_HOME/bin\n" | cat >> ~/.profile
sudo chown -R ubuntu /usr/local/hadoop
eval "echo \$HADOOP_VER" >> /usr/local/hadoop/tech_ver.txt

# Download and install Spark
curl -sL $SPARK_URL | gunzip | sudo tar xv -C /usr/local >> ~/peg_log.txt
sudo mv /usr/local/*spark* /usr/local/spark
echo "export SPARK_HOME=/usr/local/spark" | cat >> ~/.profile
echo -e "export PATH=\$PATH:\$SPARK_HOME/bin\n" | cat >> ~/.profile
sudo chown -R ubuntu /usr/local/spark
eval "echo \$SPARK_VER" >> /usr/local/spark/tech_ver.txt

# Add dependency for S3 connection
if [ ! -e /usr/local/spark/lib ]; then
	cd /usr/local/spark
	mkdir lib
	cd lib
	wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar
	wget http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.1/hadoop-aws-2.7.1.jar
	cd /usr/local/spark/conf
	rm spark-defaults.conf*
	touch spark-defaults.conf
	echo -e "spark.executor.extraClassPath /usr/local/spark/lib/aws-java-sdk-1.7.4.jar:/usr/local/spark/lib/hadoop-aws-2.7.1.jar" | cat >> spark-defaults.conf
	echo -e "spark.driver.extraClassPath /usr/local/spark/lib/aws-java-sdk-1.7.4.jar:/usr/local/spark/lib/hadoop-aws-2.7.1.jar" | cat >> spark-defaults.conf
fi