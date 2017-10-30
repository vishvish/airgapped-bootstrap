# We will need this shortly
sudo pip install --index-url=file:///shared_packages/pip/simple docker-compose

sudo yum -y install --disablerepo="*" --enablerepo="bootstrap" /shared_packages/docker/docker-17.09.0.rpm
sudo systemctl daemon-reload
sudo systemctl start docker

cd /shared_packages/docker
sudo docker-compose pull
sudo docker save -o memcached.docker memcached
sudo docker save -o postgres.docker postgres
sudo docker save -o rabbitmq.docker rabbitmq
sudo docker save -o awx_task.docker geerlingguy/awx_task
sudo docker save -o awx_web.docker geerlingguy/awx_web
