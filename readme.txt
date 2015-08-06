## Setting up Drupal environment using Vagrant in CentOS 7.

Clean up stuff need to do manually! Previous build and corresponding database.

Box available here -- https://atlas.hashicorp.com/soumyadas/boxes/Drupal-CentOS-7.1.x-64

Set up instructions --
1. $ vagrant init soumyadas/Drupal-CentOS-7.1.x-64; 
2. $ vagrant up --provider virtualbox
6. $ Vagrant ssh
7. $ build
8. Copy the host entry printed on the screen after successful build and add it directly to your windows hosts file.

Path to the build script --
/home/vagrant/build

Alias added for build to .bashrc file --
alias build="~/build/demo1.sh ~/build/demo1.conf.sh"

Alias added for code sniffer to .bashrc file --
alias sniff="phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme"


