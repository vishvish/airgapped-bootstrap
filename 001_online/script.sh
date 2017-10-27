# Download Docker rpm
curl -o '/shared_packages/docker/docker-17.09.0.rpm' \
  'https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-17.09.0.ce-1.el7.centos.x86_64.rpm'

# yum update, add epel and download pip for offline use
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y update

# Install tools to create repo
sudo yum -y install yum-utils device-mapper-persistent-data lvm2 createrepo

# Download pip
sudo yum install \
  --downloadonly \
  --installroot=/shared_data \
  --releasever=7 \
  --downloaddir=/shared_packages/rpm \
  python-pip

# Install docker and download dependencies
sudo yum install \
  --downloadonly \
  --installroot=/shared_data \
  --releasever=7 \
  --downloaddir=/shared_packages/rpm \
  /shared_packages/docker/docker-17.09.0.rpm

# Make a Yum repository
sudo createrepo --database /shared_packages/rpm

# Copy repo definition
sudo cp /shared_data/bootstrap.repo /etc/yum.repos.d/

####
# This should now work without network
####

# Install pip from local repo and then download all pip packages required for 
# Ansible
sudo yum -y install python-pip
pip download -r /shared_data/ansible-requirements.txt -d /shared_packages/pip
