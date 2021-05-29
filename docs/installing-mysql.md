## Installing mysql


Following these fairly standard looking guidelines

https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-centos-7

worked and as per details below this can be mostly automated in an easy/obvious way expect the securing stage, although I suspect there is a way around of this...



## partial automation 

This part can be realatively easily autmated 
```
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
md5sum mysql57-community-release-el7-9.noarch.rpm
rpm -ivh mysql57-community-release-el7-9.noarch.rpm
yum -y install mysql-server
systemctl start mysqld
systemctl status mysqld
grep 'temporary password' /var/log/mysqld.log
```

I don't see how to automatate
```
mysql_secure_installation
mysqladmin -u root -p version
```

i.e. as per my 100% manual stepping through the guidelines


## 100% manual steps


### Install rpms

```
[root@c7pyth4db ~]# wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
--2021-05-29 20:30:53--  https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
Resolving dev.mysql.com (dev.mysql.com)... 137.254.60.11
Connecting to dev.mysql.com (dev.mysql.com)|137.254.60.11|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://repo.mysql.com//mysql57-community-release-el7-9.noarch.rpm [following]
--2021-05-29 20:30:53--  https://repo.mysql.com//mysql57-community-release-el7-9.noarch.rpm
Resolving repo.mysql.com (repo.mysql.com)... 92.123.125.17
Connecting to repo.mysql.com (repo.mysql.com)|92.123.125.17|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 9224 (9,0K) [application/x-redhat-package-manager]
Saving to: ‘mysql57-community-release-el7-9.noarch.rpm’

100%[==================================================================================================================================================================>] 9.224       --.-K/s   in 0s      

2021-05-29 20:30:54 (138 MB/s) - ‘mysql57-community-release-el7-9.noarch.rpm’ saved [9224/9224]

[root@c7pyth4db ~]# md5sum mysql57-community-release-el7-9.noarch.rpm
1a29601dc380ef2c7bc25e2a0e25d31e  mysql57-community-release-el7-9.noarch.rpm
[root@c7pyth4db ~]# md5sum mysql57-community-release-el7-9.noarch.rpm^C
[root@c7pyth4db ~]# sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
warning: mysql57-community-release-el7-9.noarch.rpm: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY
Preparing...                          ################################# [100%]
Updating / installing...
   1:mysql57-community-release-el7-9  ################################# [100%]
[root@c7pyth4db ~]# sudo yum install mysql-server
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: centos.mirror.triple-it.nl
 * epel: mirror.neostrada.nl
 * extras: mirror.ehv.weppel.nl
 * updates: mirror.ehv.weppel.nl
mysql-connectors-community                                                                                                                                                           | 2.6 kB  00:00:00     
mysql-tools-community                                                                                                                                                                | 2.6 kB  00:00:00     
mysql57-community                                                                                                                                                                    | 2.6 kB  00:00:00     
(1/3): mysql-connectors-community/x86_64/primary_db                                                                                                                                  |  80 kB  00:00:00     
(2/3): mysql-tools-community/x86_64/primary_db                                                                                                                                       |  88 kB  00:00:00     
(3/3): mysql57-community/x86_64/primary_db                                                                                                                                           | 268 kB  00:00:00     
Resolving Dependencies
--> Running transaction check
---> Package mysql-community-server.x86_64 0:5.7.34-1.el7 will be installed
--> Processing Dependency: mysql-community-common(x86-64) = 5.7.34-1.el7 for package: mysql-community-server-5.7.34-1.el7.x86_64
--> Processing Dependency: mysql-community-client(x86-64) >= 5.7.9 for package: mysql-community-server-5.7.34-1.el7.x86_64
--> Processing Dependency: net-tools for package: mysql-community-server-5.7.34-1.el7.x86_64
--> Running transaction check
---> Package mysql-community-client.x86_64 0:5.7.34-1.el7 will be installed
--> Processing Dependency: mysql-community-libs(x86-64) >= 5.7.9 for package: mysql-community-client-5.7.34-1.el7.x86_64
---> Package mysql-community-common.x86_64 0:5.7.34-1.el7 will be installed
---> Package net-tools.x86_64 0:2.0-0.25.20131004git.el7 will be installed
--> Running transaction check
---> Package mariadb-libs.x86_64 1:5.5.68-1.el7 will be obsoleted
--> Processing Dependency: libmysqlclient.so.18()(64bit) for package: 2:postfix-2.10.1-9.el7.x86_64
--> Processing Dependency: libmysqlclient.so.18(libmysqlclient_18)(64bit) for package: 2:postfix-2.10.1-9.el7.x86_64
---> Package mysql-community-libs.x86_64 0:5.7.34-1.el7 will be obsoleting
--> Running transaction check
---> Package mysql-community-libs-compat.x86_64 0:5.7.34-1.el7 will be obsoleting
--> Finished Dependency Resolution

Dependencies Resolved

============================================================================================================================================================================================================
 Package                                                  Arch                                Version                                                  Repository                                      Size
============================================================================================================================================================================================================
Installing:
 mysql-community-libs                                     x86_64                              5.7.34-1.el7                                             mysql57-community                              2.4 M
     replacing  mariadb-libs.x86_64 1:5.5.68-1.el7
 mysql-community-libs-compat                              x86_64                              5.7.34-1.el7                                             mysql57-community                              1.2 M
     replacing  mariadb-libs.x86_64 1:5.5.68-1.el7
 mysql-community-server                                   x86_64                              5.7.34-1.el7                                             mysql57-community                              173 M
Installing for dependencies:
 mysql-community-client                                   x86_64                              5.7.34-1.el7                                             mysql57-community                               25 M
 mysql-community-common                                   x86_64                              5.7.34-1.el7                                             mysql57-community                              310 k
 net-tools                                                x86_64                              2.0-0.25.20131004git.el7                                 base                                           306 k

Transaction Summary
============================================================================================================================================================================================================
Install  3 Packages (+3 Dependent packages)

Total download size: 203 M
Is this ok [y/d/N]: y
Downloading packages:
warning: /var/cache/yum/x86_64/7/mysql57-community/packages/mysql-community-common-5.7.34-1.el7.x86_64.rpm: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY
Public key for mysql-community-common-5.7.34-1.el7.x86_64.rpm is not installed
(1/6): mysql-community-common-5.7.34-1.el7.x86_64.rpm                                                                                                                                | 310 kB  00:00:00     
(2/6): mysql-community-libs-5.7.34-1.el7.x86_64.rpm                                                                                                                                  | 2.4 MB  00:00:01     
(3/6): mysql-community-libs-compat-5.7.34-1.el7.x86_64.rpm                                                                                                                           | 1.2 MB  00:00:00     
(4/6): net-tools-2.0-0.25.20131004git.el7.x86_64.rpm                                                                                                                                 | 306 kB  00:00:00     
(5/6): mysql-community-client-5.7.34-1.el7.x86_64.rpm                                                                                                                                |  25 MB  00:00:08     
(6/6): mysql-community-server-5.7.34-1.el7.x86_64.rpm                                                                                                                                | 173 MB  00:00:38     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                       5.0 MB/s | 203 MB  00:00:40     
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
Importing GPG key 0x5072E1F5:
 Userid     : "MySQL Release Engineering <mysql-build@oss.oracle.com>"
 Fingerprint: a4a9 4068 76fc bd3c 4567 70c8 8c71 8d3b 5072 e1f5
 Package    : mysql57-community-release-el7-9.noarch (installed)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
Is this ok [y/N]: y
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
Warning: RPMDB altered outside of yum.
  Installing : mysql-community-common-5.7.34-1.el7.x86_64                                                                                                                                               1/7 
  Installing : mysql-community-libs-5.7.34-1.el7.x86_64                                                                                                                                                 2/7 
  Installing : mysql-community-client-5.7.34-1.el7.x86_64                                                                                                                                               3/7 
  Installing : net-tools-2.0-0.25.20131004git.el7.x86_64                                                                                                                                                4/7 
  Installing : mysql-community-server-5.7.34-1.el7.x86_64                                                                                                                                               5/7 
  Installing : mysql-community-libs-compat-5.7.34-1.el7.x86_64                                                                                                                                          6/7 
  Erasing    : 1:mariadb-libs-5.5.68-1.el7.x86_64                                                                                                                                                       7/7 
  Verifying  : mysql-community-libs-compat-5.7.34-1.el7.x86_64                                                                                                                                          1/7 
  Verifying  : mysql-community-common-5.7.34-1.el7.x86_64                                                                                                                                               2/7 
  Verifying  : net-tools-2.0-0.25.20131004git.el7.x86_64                                                                                                                                                3/7 
  Verifying  : mysql-community-server-5.7.34-1.el7.x86_64                                                                                                                                               4/7 
  Verifying  : mysql-community-client-5.7.34-1.el7.x86_64                                                                                                                                               5/7 
  Verifying  : mysql-community-libs-5.7.34-1.el7.x86_64                                                                                                                                                 6/7 
  Verifying  : 1:mariadb-libs-5.5.68-1.el7.x86_64                                                                                                                                                       7/7 

Installed:
  mysql-community-libs.x86_64 0:5.7.34-1.el7                      mysql-community-libs-compat.x86_64 0:5.7.34-1.el7                      mysql-community-server.x86_64 0:5.7.34-1.el7                     

Dependency Installed:
  mysql-community-client.x86_64 0:5.7.34-1.el7                        mysql-community-common.x86_64 0:5.7.34-1.el7                        net-tools.x86_64 0:2.0-0.25.20131004git.el7                       

Replaced:
  mariadb-libs.x86_64 1:5.5.68-1.el7                                                                                                                                                                        

Complete!
```

now start mysqld and get the initial password:
```
[root@c7pyth4db ~]# systemctl status mysqld
● mysqld.service - MySQL Server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:mysqld(8)
           http://dev.mysql.com/doc/refman/en/using-systemd.html
[root@c7pyth4db ~]# systemctl start mysqld
[root@c7pyth4db ~]# systemctl status mysqld
● mysqld.service - MySQL Server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
   Active: active (running) since za 2021-05-29 20:35:56 UTC; 2s ago
     Docs: man:mysqld(8)
           http://dev.mysql.com/doc/refman/en/using-systemd.html
  Process: 14665 ExecStart=/usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/mysqld.pid $MYSQLD_OPTS (code=exited, status=0/SUCCESS)
  Process: 14615 ExecStartPre=/usr/bin/mysqld_pre_systemd (code=exited, status=0/SUCCESS)
 Main PID: 14668 (mysqld)
   CGroup: /system.slice/mysqld.service
           └─14668 /usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/mysqld.pid

mei 29 20:35:51 c7pyth4db systemd[1]: Starting MySQL Server...
mei 29 20:35:56 c7pyth4db systemd[1]: Started MySQL Server.
[root@c7pyth4db ~]# grep 'temporary password' /var/log/mysqld.log
2021-05-29T20:35:53.701718Z 1 [Note] A temporary password is generated for root@localhost: ;utyUfMIa2:5
```

now this next part is fiddly

> Enter a new 12-character password that contains at least one uppercase letter, one lowercase letter, one number and one special character. Re-enter it when prompted.

```
[root@c7pyth4db ~]# mysql_secure_installation

Securing the MySQL server deployment.

New password: 

Re-enter new password: 
The 'validate_password' plugin is installed on the server.
The subsequent steps will run with the existing configuration
of the plugin.
Using existing password for root.

Estimated strength of the password: 100 
Change the password for root ? ((Press y|Y for Yes, any other key for No) : Y

New password: 

Re-enter new password: 

Estimated strength of the password: 100 
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : Y
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : Y
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : Y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : n

 ... skipping.
Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : n

 ... skipping.
All done!
```


finally basic sanity check for the new install
```
[root@c7pyth4db ~]# mysqladmin -u root -p version
Enter password: 
mysqladmin  Ver 8.42 Distrib 5.7.34, for Linux on x86_64
Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Server version		5.7.34
Protocol version	10
Connection		Localhost via UNIX socket
UNIX socket		/var/lib/mysql/mysql.sock
Uptime:			4 min 8 sec

Threads: 1  Questions: 13  Slow queries: 0  Opens: 107  Flush tables: 1  Open tables: 100  Queries per second avg: 0.052
```