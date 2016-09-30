FROM centos:5

MAINTAINER Selenium <selenium-developers@googlegroups.com>

RUN yum -y update

RUN yum install -y openssh-server

RUN sed -i 's|session required pam_loginuid.so|session optional pam_loginuid.so|g' /etc/pam.d/sshd

RUN mkdir -p /var/run/sshd

RUN yum install -y java-1.7.0-openjdk*

RUN yum install -y  -y wget

#Install Maven
RUN mkdir -p /opt/maven

WORKDIR /opt/maven

RUN wget http://apache.cs.utah.edu/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz

RUN tar -xvzf /opt/maven/apache-maven-3.0.5-bin.tar.gz

RUN rm -rf /opt/maven/apache-maven-3.0.5-bin.tar.gz

ENV M2_HOME /opt/maven/apache-maven-3.0.5

ENV MAVEN_OPTS -Xmx2048m -XX:MaxPermSize=256m

ENV PATH $PATH:dn:$M2_HOME/bin

ADD ./run.sh /usr/bin/run.sh

RUN chmod +x /usr/bin/run.sh

#RUN mkdir -p /opt/selenium && wget --no-verbose https://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.$

ENTRYPOINT ["ln -s /opt/apache-maven-3.0.5 maven"]
ENTRYPOINT ['"export PATH=$PATH:/opt/apache-maven-3.0.5/bin:/usr/lib/jvm/jre-1.7.0-openjdk.x86_64" >> ~/.bashrc']
ENTRYPOINT ["mvn"," --version"]
#CMD ["/bin/sh","/usr/bin/run.sh"]
