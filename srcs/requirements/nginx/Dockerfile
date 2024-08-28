FROM debian:bullseye 
# Install nginx
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx

RUN apt install vim -y
RUN apt install curl -y
# Create a directory for the SSL certificates
RUN mkdir -p /etc/nginx/ssl
# Install OpenSSL for generating SSL certificates
RUN apt-get install -y openssl
# Generate a self-signed SSL certificate and key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt  -subj "/C=FR/L=NI/O=42/OU=student/CN=llaurenc.42.fr"
# Copy the configuration file from the current directory and paste it inside the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Give the permissions to the directory
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
# Open port 443 for HTTPS traffic
EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]