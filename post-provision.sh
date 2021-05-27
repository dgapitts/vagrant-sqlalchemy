  echo "ADD EXTRA ALIAS VIA .bashrc"
  echo 'export PATH="$PATH:/usr/pgsql-12/bin"' >> /vagrant/bashrc.append.txt
  cat /vagrant/bashrc.append.txt >> /home/vagrant/.bashrc
  echo "alias pg='sudo su - postgres'" >> /home/vagrant/.bashrc
  echo "alias bench='sudo su - bench1'" >> /home/vagrant/.bashrc
