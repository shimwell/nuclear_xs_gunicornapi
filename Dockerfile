
FROM python:3.6
RUN pip install flask gunicorn pymongo Flask-Cors openpyxl pandas natsort
RUN apt-get update

RUN echo updating code123456
ADD flask_app /app
WORKDIR /app
EXPOSE 8080

RUN pip install pyOpenSSL

# run this beforehand
# RUN python get_database_shape.py

# CMD ["gunicorn", "--timeout", "30", "-b", "0.0.0.0:8080", "app"]
CMD ["gunicorn", "--timeout", "30", "--certfile", "/app/cloudflare.crt", "--keyfile", "/app/private_key.pem", "-b", "0.0.0.0:8080", "app"]