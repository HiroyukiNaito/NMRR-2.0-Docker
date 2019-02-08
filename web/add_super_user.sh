echo "from django.contrib.auth.models import User; User.objects.create_superuser('mgi_superuser', 'user_email@institution.com', 'mgi_superuser_pwd')" | python manage.py shell
