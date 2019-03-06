#!/bin/bash
# Wait for mongodb
until nc -z db_mongo 27017; do
    echo "=> $(date) - Waiting for confirmation of MongoDB service startup"
    sleep 1
done

echo "  ---------------------Start celery-----------------------"
rm -f *.pid
celery multi start -A nmrr worker -l info -Ofair --purge
chmod 666 ./worker.log

Wait for celery
until celery -A nmrr status 2>/dev/null; do
   echo "=> $(date) - Waiting for confirmation of Celery service startup"
   sleep 1
done

# Migrate/superuser
python manage.py migrate auth
python manage.py migrate
python manage.py compilemessages

# Collectstatic
python manage.py collectstatic --noinput

# Superuser Create
echo "from django.contrib.auth.models import User; User.objects.create_superuser('mgi_superuser', 'user_email@institution.com', 'mgi_superuser_pwd')" | python manage.py shell

# Start Django
echo "  ----------------------Start Django-----------------------"
# uwsgi --socket mysite.sock --chdir /srv/mgi-nmrr/ --wsgi-file /srv/mgi-nmrr/nmrr/wsgi.py --chmod-socket=666
python manage.py runserver 0.0.0.0:8000
echo Started
