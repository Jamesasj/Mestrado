FROM php:5.6-apache
ENV NODE_ENV=development
WORKDIR /var/www/html/App/
RUN apt-get -y update && apt-get install -y r-base
VOLUME [ "/var/www/html/App/" ] 
COPY . /var/www/html/App/
EXPOSE 80