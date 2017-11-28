# yum update, add epel and download pip for offline use
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
sudo yum -y update

# Install tools to create repo
sudo yum -y install yum-utils device-mapper-persistent-data lvm2 createrepo

# Download python 3
sudo yum install \
  --downloadonly \
  --installroot=/shared_data \
  --releasever=7 \
  --downloaddir=/shared_packages/rpm \
  python36u

# Download pip for python 3
sudo yum install \
  --downloadonly \
  --installroot=/shared_data \
  --releasever=7 \
  --downloaddir=/shared_packages/rpm \
  python36u-pip

# Download headers for python 3
sudo yum install \
  --downloadonly \
  --installroot=/shared_data \
  --releasever=7 \
  --downloaddir=/shared_packages/rpm \
  python36u-devel

echo "Making local yum repository"

# Make a Yum repository
sudo createrepo --database /shared_packages/rpm

echo "Adding local yum repo to machine configuration"

# Copy repo definition
sudo cp /shared_packages/bootstrap.repo /etc/yum.repos.d/

####
# This should now work without network
####
# exit
# Install pip from local repo and then download all pip packages required for 
# Ansible
sudo yum -y install python36u-pip
sudo pip3.6 install pip2pi

echo "Saving pip-compatible packages"

pip2tgz /shared_packages/pip -r /shared_packages/ansible-requirements.txt
dir2pi /shared_packages/pip

