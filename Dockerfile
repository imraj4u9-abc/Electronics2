FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    curl \
    apt-transport-https \
    ca-certificates

# Add Microsoft SQL Server repo
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/12/prod.list \
    > /etc/apt/sources.list.d/mssql-release.list

# Install ODBC Driver
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Install PDO_SQLSRV
RUN pecl install pdo_sqlsrv \
    && docker-php-ext-enable pdo_sqlsrv

# Enable Apache rewrite
RUN a2enmod rewrite

WORKDIR /var/www/html
COPY . .

EXPOSE 80
