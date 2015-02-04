_Outreach Application Deployment Steps in CentOS 7_
=============================================
These install instructions are still in progress.  See TBDs for more
information.  

This is the PCNI Mobile Outreach App.  See
https://github.com/PCNI/outreach-app.

Note that Eclipse is preferred, but not required, to install this
application.  However, these instructions assume that you are working
from the command line.
TBD: Add Eclipse instructions.

System Requirements
---------------------
Note: see
https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-centos-7
if you need help setting up these requirements.  
1. CentOS 7 Server with minimum 4 GB RAM,  300 MB Disk Space  
2. JDK 1.7 Installed   
    `yum install java-1.7.0-openjdk`  
3. MySQL / MariaDB Server 5.3 and higher running  
    `yum install mariadb-server mariadb`  
4. Apache HTTP Server Installed and running  
    `yum install httpd`  
5. outreach.war file built using maven  
     _TBD: add instructions for building this_  
6. outreach.properties file   


Deployment Steps
-----------------
1. Login to CentOS 7 server as root user.
2. Install wget using the following command

    `yum -y install wget`  

3. Navigate to /tmp directory  

    `cd /tmp`

4. Download Jetty using the following command  

    `wget http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.2.7.v20150116.tar.gz&r=1`  
    `# this may download an html file, in which case you should
    download the tar.gz file locally and scp it onto the server`  

5. Extract the downloaded archive file to /opt  

    `tar zxvf jetty-distribution-9.2.5.v20141112.tar.gz -C /opt/  
    // note that the distribution number may be different.    
    // check your filename if you encounter the following error:`  
    `tar (child): jetty-distribution-9.2.5.v20141112.tar.gz: Cannot open: No such file or directory  
    tar (child): Error is not recoverable: exiting now  
    tar: Child returned status 2  
    tar: Error is not recoverable: exiting now`  
    
6. Rename it to jetty  
    
    `mv /opt/jetty-distribution-9.2.5.v20141112/ /opt/jetty`  

7. Create a user called jetty to run jetty web server on system start-up.  
    
    `useradd -m jetty`

8. Change ownership of extracted jetty directory.  

    `chown -R jetty:jetty /opt/jetty/`  

9. Copy or Symlink jetty.sh to /etc/init.d directory to create a start up script file for jetty web server.  `

    `ln -s /opt/jetty/bin/jetty.sh /etc/init.d/jetty`  

10. Add script.  

    `chkconfig --add jetty`  

11. Auto start at 3,4 and 5 levels.  

    `chkconfig --level 345 jetty on`  


12. Add the following information in /etc/default/jetty, replace port and listening address with your value.  

     `vi /etc/default/jetty`  

    JAVA\_OPTIONS=" -server -Xms1536m -Xmx1536m -XX:+DisableExplicitGC -Doutreach-app-config=/opt/jetty/config/outreach.properties -Dfile.encoding=UTF-8"  
    JETTY\_HOME=/opt/jetty  
    JETTY\_USER=jetty  
    JETTY\_PORT=8080  
    JETTY\_HOST=< SERVER_IP >  
    JETTY\_LOGS=/opt/jetty/logs/  

13. Now start the jetty service.  

    `service jetty start`  

14. Open web browser and navigate to http://< SERVER_IP>:8080/ and verify whether the web server is accessible  

15. Login to MySQL, create a user and database with name outreach, and
grant all permissions to the user on that database    

    `User Name: outreach  
    Host: localhost`

16. Create a directory named outreach in apache web root directory  

    `mkdir –p /var/www/html/outreach`  


17. Change ownership of the /var/www/html/outreach directory to jetty  

    `chown -R jetty:jetty /var/www/html/outreach`  

18. Change user to jetty  

    `su - jetty`  

19. Create a directory config in jetty home directory  

    `mkdir –p /opt/jetty/config`  

20. Create a file outreach.properties in /opt/jetty/config directory with the following content  
    _TBD: where are the credentials for smtp coming from?_  
    `vi /opt/jetty/config/outreach.properties  `

    `# Database Configuration`  
    org.hibernate.dialect=org.hibernate.dialect.MySQL5Dialect  
    jdbc.driverClassName=com.mysql.jdbc.Driver  
    jdbc.url=jdbc:mysql://localhost:3306/outreach  
    jdbc.username=outreach  
    jdbc.password=password  
      
    jdbc.connection.acquireIncrement=2  
    jdbc.connection.initialPoolSize=5  
    jdbc.connection.minPoolSize=15  
    jdbc.connection.maxPoolSize=80  
    jdbc.connection.idleConnectionTestPeriod=60  
    jdbc.connection.maxIdleTime=55  
     
    default.cdn.url.root=http://< Server IP>/outreach  
    default.cdn.origin.dir=/var/www/html/outreach  
    domainVerifier=< Server IP>  
    smtp.host=smtp.mandrillapp.com  
    smtp.port=587  
    smtp.use.ssl=true  
    smtp.username=test@example.com  
    smtp.password=Test  
    email.from=admin@salzertechnologies.com  
  
  
21. Create the following directories  

    `mkdir –p /var/log/outreach  `  
    mkdir –p /var/log/jetty  
    mkdir –p /opt/jetty/work  
  
    _TBD: add build file and instructions for compiling .java files_  
    _TBD: include instructions for creating the outreach.war file here_  

22. Copy outreach.war to /opt/jetty/webapps directory  
  
23. Restart the jetty server  

    `service jetty restart`  
  
24. The application can be accessed using the following URL  
  
    `http://<SERVER IP>:8080/outreach`
