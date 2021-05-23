## vagrant scp


### install

```
[~/projects/vagrant-sqlalchemy] # vagrant plugin install vagrant-vbguest
Installing the 'vagrant-vbguest' plugin. This can take a few minutes...
Fetching: micromachine-3.0.0.gem (100%)
Fetching: vagrant-vbguest-0.29.0.gem (100%)
Installed the plugin 'vagrant-vbguest (0.29.0)'!
[~/projects/vagrant-sqlalchemy] # vagrant plugin install vagrant-scp
Installing the 'vagrant-scp' plugin. This can take a few minutes...
Fetching: vagrant-scp-0.5.7.gem (100%)
Installed the plugin 'vagrant-scp (0.5.7)'!
```

### usage - a bit fiddly at first

this didn't work
```
[~/projects/vagrant-sqlalchemy] # vagrant scp vagrant@127.0.0.1:/vagrant/pg_bench_s3_data.sql .
The machine with the name 'vagrant@127.0.0.1' was not found configured for
this Vagrant environment.
```

I have multiple vagrant boxes with a `name` of `default` but `id` is uniqie e.g. `ab98c57`

```
[~/projects/vagrant-sqlalchemy] # vagrant global-status
id       name    provider   state    directory                                              
--------------------------------------------------------------------------------------------
56b4b79  default virtualbox poweroff /home/dpitts/projects/vagrant-ansible-for-devops       
1838b0f  db1     virtualbox poweroff /home/dpitts/projects/vagrant-ansible-slony            
64ff76c  db2     virtualbox poweroff /home/dpitts/projects/vagrant-ansible-slony            
4d9e81a  default virtualbox poweroff /home/dpitts/projects/vagrant-puppet                   
e563320  default virtualbox running  /home/dpitts/projects/vagrant-postgres12               
19fa8be  default virtualbox poweroff /home/dpitts/projects/vagrant-centos7-npm              
f6be43c  default virtualbox running  /home/dpitts/projects/vagrant-centos7-statsd           
2feb40b  default virtualbox poweroff /home/dpitts/projects/vagrant-centos7-cockroachdb      
ab98c57  default virtualbox running  /home/dpitts/projects/vagrant-advanced-python-with-dbs 
 
The above shows information about all known Vagrant environments
on this machine. This data is cached and may not be completely
up-to-date. To interact with any of the machines, you can go to
that directory and run Vagrant, or you can use the ID directly
with Vagrant commands from any directory. For example:
"vagrant destroy 1a2b3c4d"
```
but this didn't work
```
[~/projects/vagrant-sqlalchemy] # vagrant scp ab98c57:/vagrant/pg_bench_s3_data.sql .
The provider for this Vagrant-managed machine is reporting that it
is not yet ready for SSH. Depending on your provider this can carry
different meanings. Make sure your machine is created and running and
try again. Additionally, check the output of `vagrant status` to verify
that the machine is in the state that you expect. If you continue to
get this error message, please view the documentation for the provider
you're using.
[~/projects/vagrant-sqlalchemy] # vagrant ssh ab98c57
VM must be created before running this command. Run `vagrant up` first.
```

However after rebuilding the project (i.e. after installing vagrant-vbguest and vagrant-scp)

```
[~/projects/vagrant-sqlalchemy] # vagrant global-status
id       name    provider   state    directory                                         
---------------------------------------------------------------------------------------
56b4b79  default virtualbox poweroff /home/dpitts/projects/vagrant-ansible-for-devops  
1838b0f  db1     virtualbox poweroff /home/dpitts/projects/vagrant-ansible-slony       
64ff76c  db2     virtualbox poweroff /home/dpitts/projects/vagrant-ansible-slony       
4d9e81a  default virtualbox poweroff /home/dpitts/projects/vagrant-puppet              
e563320  default virtualbox running  /home/dpitts/projects/vagrant-postgres12          
19fa8be  default virtualbox poweroff /home/dpitts/projects/vagrant-centos7-npm         
f6be43c  default virtualbox running  /home/dpitts/projects/vagrant-centos7-statsd      
2feb40b  default virtualbox poweroff /home/dpitts/projects/vagrant-centos7-cockroachdb 
9629d5e  default virtualbox running  /home/dpitts/projects/vagrant-sqlalchemy          
 
The above shows information about all known Vagrant environments
on this machine. This data is cached and may not be completely
up-to-date. To interact with any of the machines, you can go to
that directory and run Vagrant, or you can use the ID directly
with Vagrant commands from any directory. For example:
"vagrant destroy 1a2b3c4d"
```
the vagrant-scp worked
```
[~/projects/vagrant-sqlalchemy] #  vagrant scp 9629d5e:/home/vagrant/pg_bench_schema_only.sql .
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
pg_bench_schema_only.sql                                           100% 2341     2.3KB/s   00:00   
```
