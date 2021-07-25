#! /bin/bash
if [ ! -f /home/vagrant/already-installed-flag ]
then
  echo "ADD EXTRA ALIAS VIA .bashrc"
  echo 'export PATH="$PATH:/usr/pgsql-12/bin"' >> /vagrant/bashrc.append.txt
  cat /vagrant/bashrc.append.txt >> /home/vagrant/.bashrc
  echo "alias pg='sudo su - postgres'" >> /home/vagrant/.bashrc
  echo "alias bench='sudo su - bench1'" >> /home/vagrant/.bashrc


  #echo "GENERAL YUM UPDATE"
  #yum -y update
  #echo "INSTALL GIT"
  yum -y install git
  #echo "INSTALL TREE"
  yum -y install tree
  #echo "INSTALL unzip curl wget lsof"
  yum  -y install unzip curl wget lsof 
  # install sysstat
  yum -y install sysstat
  systemctl start sysstat
  systemctl enable sysstat


  # Regular pg12 install                                                                           
  # As of 15 April 2019, there is only one repository RPM per distro, and it includes repository information for all available PostgreSQL releases.
  rpm -ivh https://yum.postgresql.org/9.6/redhat/rhel-7.3-x86_64/pgdg-redhat-repo-latest.noarch.rpm
  #rpm -Uvh https://yum.postgresql.org/12/redhat/rhel-7-x86_64/pgdg-centos12-12-2.noarch.rpm

  yum -y update
  yum -y install postgresql12-server postgresql12
  yum -y install postgresql12-contrib postgresql12-libs postgresql12-devel
 
  # Extra packages and devtool for install of https://github.com/ossc-db/pg_plan_advsr  
  #yum -y install postgresql-devel
  yum -y install gcc

  # setup pg_hba.conf and start pg12
  cp /vagrant/pg_hba.conf /tmp/pg_hba.conf
  #su -c "cp -p /var/lib/pgsql/12/data/pg_hba.conf /var/lib/pgsql/12/data/pg_hba.conf.`date '+%Y%m%d-%H%M'`.bak" -s /bin/sh postgres
  #su -c "cat /tmp/pg_hba.conf > /var/lib/pgsql/12/data/pg_hba.conf" -s /bin/sh postgres
  /usr/pgsql-12/bin/postgresql-12-setup initdb
  systemctl enable postgresql-12.service
  systemctl start postgresql-12.service 

  # install pgbouncer (setup to be completed)
  yum -y install pgbouncer
  #cp /vagrant/pgbouncer.ini /etc/pgbouncer/pgbouncer.ini
  #cp /vagrant/userlist.txt /etc/pgbouncer/userlist.txt
  
  # Postgres adapter for Python
  yum -y install python-psycopg2
  
  # prevent vagrant user ssh warning "setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory"
  sudo cat /vagrant/environment >> /etc/environment

  # setup bench1 linux user
  adduser bench1
  # setup bench1 postgres user and database
  su -c "createuser bench1" -s /bin/sh postgres
  su -c "createdb bench1"  -s /bin/sh postgres
  # setup vagrant postgres user and database
  su -c "createuser vagrant" -s /bin/sh postgres
  su -c "createdb vagrant"  -s /bin/sh postgres


  # setup environment variables and extra alias for postgres and bench1 user
  cp /vagrant/bashrc.append.txt /tmp/bashrc.append.txt
  su -c "cat /tmp/bashrc.append.txt >> ~/.bashrc" -s /bin/sh postgres
  su -c "cat /tmp/bashrc.append.txt >> ~/.bash_profile" -s /bin/sh postgres
  su -c "cat /tmp/bashrc.append.txt >> ~/.bashrc" -s /bin/sh bench1

  # initial data load for 
  su -c "/usr/pgsql-12/bin/pgbench -i -s 30" -s /bin/sh bench1
  su -c "/usr/pgsql-12/bin/pgbench -i -s 3" -s /bin/sh vagrant

  # download monitoring and demo scripts to common directory i.e. accessible by postgres, bench1 and vagrant databases
  cd /
  git clone https://github.com/dgapitts/pg-ora-demo-scripts.git
  chmod 777 -R /pg-ora-demo-scripts
  ls -rl /pg-ora-demo-scripts
  
  # install mysql
  yum -y install mysql-community-server
  
  # initial cron
  crontab /vagrant/root_cronjob_monitoring_sysstat_plus_custom_pgmon.txt


  # Add ShellCheck https://github.com/koalaman/shellcheck - a great tool for testing and improving the quality of shell scripts
  yum -y install epel-release
  yum -y install ShellCheck

  # add sqlalchemy module
  pip3 install sqlalchemy
else
  echo "already installed flag set : /home/vagrant/already-installed-flag"
fi

