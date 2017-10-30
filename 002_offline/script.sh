# Install net-tools for they are missing
sudo yum -y install net-tools

# Remove the default route to disable external Internet access
sudo /sbin/route del default

# Copy repo definition
sudo cp /shared_packages/bootstrap.repo /etc/yum.repos.d/

sudo yum install --disablerepo="*" --enablerepo="bootstrap" python-pip

sudo yum install --disablerepo="*" --enablerepo="bootstrap" /shared_packages/docker/docker-17.09.0.rpm

