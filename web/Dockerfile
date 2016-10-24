############################################################
# Dockerfile to run a Django-based web application
# Based on an Ubuntu Image
############################################################

# Set the base image to use to Ubuntu
FROM ubuntu:14.04

# Set the file maintainer (your name - the file's author)
MAINTAINER National Institute Of Standards and Technology

# Set env variables used in this Dockerfile (add a unique prefix, such as DOCKYARD)
# Directory in container for project source files
ENV DOCKYARD_SRVPROJ=/srv/mgi-mdcs
# Git repository
ENV GIT_REPO=https://github.com/usnistgov/MDCS.git

# Update the default application repository sources list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python python-pip
RUN apt-get install -y libxml2-dev libxslt-dev python-dev lib32z1-dev
RUN apt-get install -y curl python
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py
RUN apt-get install -y mongodb-org
RUN apt-get install -y redis-server
RUN apt-get -y install git
RUN apt-get -y install python-psycopg2

# Git clone
RUN git clone $GIT_REPO $DOCKYARD_SRVPROJ
RUN chmod 777 $DOCKYARD_SRVPROJ

# Install Python dependencies
RUN pip install -r $DOCKYARD_SRVPROJ/docs/requirements.txt

# Install mongoengine
RUN git clone "https://github.com/MongoEngine/django-mongoengine.git"
RUN cd django-mongoengine && python setup.py install

# Install uwsgi
RUN pip install uwsgi

# Port to expose
EXPOSE 8000

# create unprivileged user
RUN adduser --disabled-password --gecos '' myuser

# Add superuser script
COPY add_super_user.sh $DOCKYARD_SRVPROJ/add_super_user.sh
RUN chmod +x $DOCKYARD_SRVPROJ/add_super_user.sh

# Copy entrypoint script into the image
WORKDIR $DOCKYARD_SRVPROJ
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
