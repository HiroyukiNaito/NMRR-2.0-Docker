# Install docker

## On MAC and Windows (Docker Toolbox)
Download docker toolbox at [Docker Toolbox](https://www.docker.com/products/docker-toolbox)
> Docker toolbox contains:
>  Docker Compose,
>  Docker Machine
>  and Kitematic

## On Linux

### Get Docker
```
$ wget -qO- https://get.docker.com/ | sh
```
### Get Docker compose
```
$ sudo apt-get install python-pip
$ sudo pip install docker-compose
```

## Run the software for the first time
> You might need to launch the following commands with root privileges

### Build the docker-compose.yml file
```
$ docker-compose build
```
### Init the mongo database
#### Launch the container
```
$ docker-compose up db
```
> Wait for the launch of the database 

#### Connect to the container to launch the init script
In a new tab or console:
```
$ docker exec -it db_mongo /bin/bash
$ ./set_mongodb_password.sh
$ exit
```
Stop the container:
```
$ docker-compose stop db
```

## Run the software
```
$ docker-compose up -d
```
> The `-d` parameter launches the project in detach mode

## Stop the software
```
$ docker-compose stop
```

## Access
For the access, go to : http://127.0.0.1:80/

## Initial Super user

* username: mgi_superuser
* password: mgi_superuser_pwd







