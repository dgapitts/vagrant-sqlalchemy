## Vagrant mount failures and my workaround - vagrant reload && sudo /vagrant/post-provision.sh

As below, I'm hitting a relatively common vagrant provisioning/mount issue 
i.e. [stackover flow thread](https://stackoverflow.com/questions/22717428/vagrant-error-failed-to-mount-folders-in-linux-guest) 


to get around this reload the project

```
vagrant reload
vagrant ssh
```
and then from within the VM we will need to re-run some of the provisioning steps 

```
sudo /vagrant/post-provision.sh
```

## Details
While working on this projoect, i've been hittig some quirky vagrant build errors `umount: /mnt: not mounted`

```
[~/projects/vagrant-sqlalchemy] # time vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'https://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1804_02.VirtualBox.box'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: sqlalchemy
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 8080 (guest) => 8088 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: 
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default: 
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
[default] No Virtualbox Guest Additions installation found.
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.widexs.nl
 * extras: mirror.seedvps.com
 * updates: centos.mirror.transip.nl
Resolving Dependencies
--> Running transaction check
---> Package centos-release.x86_64 0:7-5.1804.el7.centos will be updated
---> Package centos-release.x86_64 0:7-9.2009.1.el7.centos will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package             Arch        Version                     Repository    Size
================================================================================
Updating:
 centos-release      x86_64      7-9.2009.1.el7.centos       updates       27 k

Transaction Summary
================================================================================
Upgrade  1 Package

Total download size: 27 k
Downloading packages:
No Presto metadata available for updates
warning: /var/cache/yum/x86_64/7/updates/packages/centos-release-7-9.2009.1.el7.centos.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
Public key for centos-release-7-9.2009.1.el7.centos.x86_64.rpm is not installed
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Importing GPG key 0xF4A80EB5:
 Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
 Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
 Package    : centos-release-7-5.1804.el7.centos.x86_64 (@anaconda)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : centos-release-7-9.2009.1.el7.centos.x86_64                  1/2 
warning: /etc/yum/vars/contentdir created as /etc/yum/vars/contentdir.rpmnew
  Cleanup    : centos-release-7-5.1804.el7.centos.x86_64                    2/2 
  Verifying  : centos-release-7-9.2009.1.el7.centos.x86_64                  1/2 
  Verifying  : centos-release-7-5.1804.el7.centos.x86_64                    2/2 

Updated:
  centos-release.x86_64 0:7-9.2009.1.el7.centos                                 

Complete!
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.widexs.nl
 * extras: mirror.seedvps.com
 * updates: centos.mirror.transip.nl
No package kernel-devel-3.10.0-862.2.3.el7.x86_64 available.
Error: Nothing to do
Unmounting Virtualbox Guest Additions ISO from: /mnt
umount: /mnt: not mounted
==> default: Checking for guest additions in VM...
    default: No guest additions were detected on the base box for this VM! Guest
    default: additions are required for forwarded ports, shared folders, host only
    default: networking, and more. If SSH fails on this machine, please install
    default: the guest additions and repackage the box to continue.
    default: 
    default: This is not an error message; everything may continue to work properly,
    default: in which case you may ignore this message.
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

umount /mnt

Stdout from the command:



Stderr from the command:

umount: /mnt: not mounted


real	0m58.526s
user	0m4.544s
sys	0m3.224s

```

rebuilding the whole project didn't help.

Googling I found this [stackover flow thread](https://stackoverflow.com/questions/22717428/vagrant-error-failed-to-mount-folders-in-linux-guest) and what did help was `vagrant reload`

```
[~/projects/vagrant-sqlalchemy] # vagrant reload
==> default: Attempting graceful shutdown of VM...
    default: 
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default: 
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 8080 (guest) => 8088 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
==> default: Machine booted and ready!
[default] No Virtualbox Guest Additions installation found.
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.ams1.nl.leaseweb.net
 * epel: epel.mirror.wearetriple.com
 * extras: ams.edge.kernel.org
 * updates: ftp.nluug.nl
Package gcc-4.8.5-44.el7.x86_64 already installed and latest version
Package binutils-2.27-44.base.el7.x86_64 already installed and latest version
Package 1:make-3.82-24.el7.x86_64 already installed and latest version
Package 4:perl-5.16.3-299.el7_9.x86_64 already installed and latest version
Package bzip2-1.0.6-13.el7.x86_64 already installed and latest version
Resolving Dependencies
--> Running transaction check
---> Package elfutils-libelf-devel.x86_64 0:0.176-5.el7 will be installed
--> Processing Dependency: pkgconfig(zlib) for package: elfutils-libelf-devel-0.176-5.el7.x86_64
---> Package kernel-devel.x86_64 0:3.10.0-1160.25.1.el7 will be installed
--> Running transaction check
---> Package zlib-devel.x86_64 0:1.2.7-19.el7_9 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package                  Arch      Version                    Repository  Size
================================================================================
Installing:
 elfutils-libelf-devel    x86_64    0.176-5.el7                base        40 k
 kernel-devel             x86_64    3.10.0-1160.25.1.el7       updates     18 M
Installing for dependencies:
 zlib-devel               x86_64    1.2.7-19.el7_9             updates     50 k

Transaction Summary
================================================================================
Install  2 Packages (+1 Dependent package)

Total download size: 18 M
Installed size: 38 M
Downloading packages:
No Presto metadata available for updates
--------------------------------------------------------------------------------
Total                                              3.1 MB/s |  18 MB  00:05     
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : zlib-devel-1.2.7-19.el7_9.x86_64                             1/3 
  Installing : elfutils-libelf-devel-0.176-5.el7.x86_64                     2/3 
  Installing : kernel-devel-3.10.0-1160.25.1.el7.x86_64                     3/3 
  Verifying  : kernel-devel-3.10.0-1160.25.1.el7.x86_64                     1/3 
  Verifying  : zlib-devel-1.2.7-19.el7_9.x86_64                             2/3 
  Verifying  : elfutils-libelf-devel-0.176-5.el7.x86_64                     3/3 

Installed:
  elfutils-libelf-devel.x86_64 0:0.176-5.el7                                    
  kernel-devel.x86_64 0:3.10.0-1160.25.1.el7                                    

Dependency Installed:
  zlib-devel.x86_64 0:1.2.7-19.el7_9                                            

Complete!
Downloading VirtualBox Guest Additions ISO from https://download.virtualbox.org/virtualbox/5.1.38/VBoxGuestAdditions_5.1.38.iso
Copy iso file /home/dpitts/.vagrant.d/tmp/VBoxGuestAdditions_5.1.38.iso into the box /tmp/VBoxGuestAdditions.iso
Mounting Virtualbox Guest Additions ISO to: /mnt
mount: /dev/loop0 is write-protected, mounting read-only
Installing Virtualbox Guest Additions 5.1.38 - guest version is unknown
Verifying archive integrity... All good.
Uncompressing VirtualBox 5.1.38 Guest Additions for Linux...........
VirtualBox Guest Additions installer
Copying additional installer modules ...
Installing additional modules ...
vboxadd.sh: Starting the VirtualBox Guest Additions.

Could not find the X.Org or XFree86 Window System, skipping.
Redirecting to /bin/systemctl start vboxadd.service
Redirecting to /bin/systemctl start vboxadd-service.service
Unmounting Virtualbox Guest Additions ISO from: /mnt
Cleaning up downloaded VirtualBox Guest Additions ISO...
==> default: Checking for guest additions in VM...
==> default: Setting hostname...
==> default: Rsyncing folder: /home/dpitts/projects/vagrant-sqlalchemy/ => /vagrant
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run

```

and finally tidy-up some provisioning steps which were skipped (as they depend on /vagrant cross-mount)

```
[~/projects/vagrant-sqlalchemy] # vagrant reload
==> vagrant: A new version of Vagrant is available: 2.2.16!
==> vagrant: To upgrade visit: https://www.vagrantup.com/downloads.html

==> default: Attempting graceful shutdown of VM...
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 8080 (guest) => 8088 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
==> default: Machine booted and ready!
[default] GuestAdditions 5.1.38 running --- OK.
==> default: Checking for guest additions in VM...
==> default: Setting hostname...
==> default: Rsyncing folder: /home/dpitts/projects/vagrant-sqlalchemy/ => /vagrant
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.
[~/projects/vagrant-sqlalchemy] # vagrant ssh
Last login: Wed May 26 19:32:27 2021 from 10.0.2.2
[vagrant@c7pyth4db ~]$ cd /vagrant/
[vagrant@c7pyth4db vagrant]$ ls -ltr
total 32
-rw-rw-r--. 1 vagrant vagrant  176 22 mei 18:05 bashrc.append.txt
-rw-rw-r--. 1 vagrant vagrant 2341 23 mei 20:45 pg_bench_schema_only.sql
-rw-rw-r--. 1 vagrant vagrant  435 25 mei 17:41 sqlalchemy-intro.py
-rw-rw-r--. 1 vagrant vagrant  585 25 mei 17:44 Vagrantfile
-rw-rw-r--. 1 vagrant vagrant 3776 25 mei 19:17 provision.sh
drwxrwxr-x. 2 vagrant vagrant  164 26 mei 20:25 docs
-rw-rw-r--. 1 vagrant vagrant 1800 26 mei 20:26 README.md
-rw-rw-r--. 1 vagrant vagrant  477 26 mei 20:27 sqlalchemy-intro-python.py
-rw-rw-r--. 1 vagrant vagrant  301 27 mei 20:42 post-provision.sh
[vagrant@c7pyth4db vagrant]$ cat post-provision.sh
  echo "ADD EXTRA ALIAS VIA .bashrc"
  echo 'export PATH="$PATH:/usr/pgsql-12/bin"' >> /vagrant/bashrc.append.txt
  cat /vagrant/bashrc.append.txt >> /home/vagrant/.bashrc
  echo "alias pg='sudo su - postgres'" >> /home/vagrant/.bashrc
  echo "alias bench='sudo su - bench1'" >> /home/vagrant/.bashrc
[vagrant@c7pyth4db vagrant]$ bash post-provision.sh
ADD EXTRA ALIAS VIA .bashrc
[vagrant@c7pyth4db vagrant]$ h40
-bash: h40: command not found
[vagrant@c7pyth4db vagrant]$ exit
logout
Connection to 127.0.0.1 closed.
[~/projects/vagrant-sqlalchemy] # vagrant ssh
Last login: Thu May 27 20:47:54 2021 from 10.0.2.2
[c7pyth4db:vagrant:~] # h40
   20  D
   21  exit
   22  h
```
