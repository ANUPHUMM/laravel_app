# Use the official PHP 7.2 image as a base
FROM php:7.2-apache

# Set the working directory in the container
WORKDIR /var/www/html

# Install PHP extensions and libraries
RUN apt-get update && \
    apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip unzip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd pdo pdo_mysql

# Enable mod_rewrite for Apache
RUN a2enmod rewrite

# Copy composer.lock and composer.json to the working directory
COPY composer.lock composer.json /var/www/html/

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies
RUN composer install --no-scripts --no-autoloader --no-interaction --prefer-dist

# Copy the rest of the application to the container
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
# Use the official PHP 7.2 image as a base
FROM php:7.2-apache

# Set the working directory in the container
WORKDIR /var/www/html

# Install PHP extensions and libraries
RUN apt-get update && \
    apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip unzip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd pdo pdo_mysql

# Enable mod_rewrite for Apache
RUN a2enmod rewrite

# Copy composer.lock and composer.json to the working directory
COPY composer.lock composer.json /var/www/html/

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies
RUN composer install --no-scripts --no-autoloader --no-interaction --prefer-dist

# Copy the rest of the application to the container
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
