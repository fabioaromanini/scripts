# Scripts

Bash scripts to execute repetitive tasks I must perform every time I mess up my developing environment.

### 0.9
* Install a specified **stable** version of docker
* Store docker's volumes in a specific directory, using symbolic links
* Checks if the disk that contains docker's volume directory is mounted

### 0.9.1
* Enables user to choose between a docker stable or edge release

### 0.9.2
* Adds user to docker group
* Installs docker-machine and docker-compose
* Store docker's images in a specific director, also using symbolic links
* Adds autocomplete for docker's commands.

### 0.9.3
* Adds script to generate ssh-key
* Allows ssh via https ports to github.com servers

### 0.9.4
* Adds script that sets nvm
* List instructions on how to set edge and lts releases for node and npm

### 0.9.5
* Removes previous docker-config dir before installing
* 0.9.5.1: moves /var/lib/docker to /mnt/docker/var, and creates sym links

## Coming soon

### 0.9.6
* Adds script to mount disks on startup

### 0.9.7
* Log formatting
