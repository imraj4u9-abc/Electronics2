FROM php:8.2-apache

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    apt-transport-https \
    ca-certificates

# Add Microsoft GPG key (NEW WAY – no apt-key)
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | tee /usr/share/keyrings/microsoft-prod.gpg > /dev/null

# Add Microsoft SQL Server repo
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] \
    https://packages.microsoft.com/debian/12/prod bookworm main" \
    > /etc/apt/sources.list.d/mssql-release.list

# Install Microsoft ODBC Driver 18
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Install PDO_SQLSRV
RUN pecl install pdo_sqlsrv \
    && docker-php-ext-enable pdo_sqlsrv

# Enable Apache rewrite
RUN a2enmod rewrite

WORKDIR /var/www/html
COPY . .

EXPOSE 80
