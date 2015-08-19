FROM quay.io/whathood/docker-nginx:1.0

RUN apt-get update

# OPCACHE
ADD build/opcache-dev.ini   /etc/php5/fpm/mods-available/opcache-dev.ini
RUN ln -s /etc/php5/fpm/mods-available/opcache-dev.ini /etc/php5/fpm/conf.d/06-opcache-dev.ini

# install xdebug and webgrind
RUN apt-get install -y unzip php5-dev php-pear php5-json
RUN pecl install xdebug
RUN echo 'zend_extension="/usr/lib/php5/20121212/xdebug.so"' >> /etc/php5/fpm/php.ini
# enable xdebug
RUN echo 'xdebug.profiler_enable = 1' >> /etc/php5/fpm/php.ini

# WEBGRIND
RUN wget https://webgrind.googlecode.com/files/webgrind-release-1.0.zip
RUN unzip webgrind-release-1.0.zip
RUN mv webgrind /var/www

