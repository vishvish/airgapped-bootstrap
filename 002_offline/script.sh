# Install net-tools for they are missing
sudo yum -y install net-tools

# Remove the default route to disable external Internet access
sudo /sbin/route del default

# Copy repo definition
sudo cp /shared_packages/bootstrap.repo /etc/yum.repos.d/

sudo yum -y install --disablerepo="*" --enablerepo="bootstrap" python-pip

sudo yum -y install --disablerepo="*" --enablerepo="bootstrap" /shared_packages/docker/docker-17.09.0.rpm

sudo systemctl start docker

sudo pip install --index-url=file:///shared_packages/pip/simple docker-compose

cd /shared_packages/docker
sudo docker load -i memcached.docker
sudo docker load -i postgres.docker
sudo docker load -i rabbitmq.docker
sudo docker load -i awx_task.docker
sudo docker load -i awx_web.docker

cd /shared_dependencies/awx
docker-compose up -d
