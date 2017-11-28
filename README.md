# Airgap Bootstrap

### Proposition

Create an artefact in an online environment that is copied to the offline airgapped environment.

Artefact contains everything needed to standup an instance of AWX, the open-source version of Ansible Tower. Artefact should also contain playbooks for Kubernetes and other shared services required, such as JIRA, Confluence, Gitlab, Artifactory, etc.

#### How it works

Two Vagrant Machines.

One online, one offline.

Bringing the first, online machine, up (`vagrant up`) results in it downloading all the rpm and pip packages it needs, creating a yum repository and pip repo, and putting all these files into the `shared_packages` folder. It also downloads a new docker rpm directly from docker.

Then comes the second machine. Under Vagrant, the first thing this does is to install `net-tools` and then disable the default route to prevent Internet access.
