FROM espocrm/espocrm:latest

RUN apt update && apt install -y curl unzip jq cron joe nano && \
    URL=$(curl -s https://api.github.com/repos/espocrm/espocrm/releases/latest | jq -r '.assets[] | select(.name | test("EspoCRM.*\\.zip")) | .browser_download_url') && \
    curl -L -A "Mozilla/5.0" -o /tmp/espocrm.zip "$URL" && \
    unzip /tmp/espocrm.zip -d /tmp && mv /tmp/EspoCRM-*/* /var/www/html && \
    rm -rf /tmp/espocrm.zip /tmp/EspoCRM-* && \
    chown -R www-data:www-data /var/www/html && \
    find /var/www/html -type d -exec chmod 755 {} + && \
    find /var/www/html -type f -exec chmod 644 {} + && \
    a2enmod rewrite && \
    bash -c 'cat > /etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /var/www/html/public/

    Alias /client/ /var/www/html/client/

    <Directory /var/www/html/public/>
        AllowOverride All
        Require all granted
    </Directory>

    <Directory /var/www/html/client/>
        Require all granted
    </Directory>
</VirtualHost>
EOF' && \
    service apache2 restart && \
    echo '* * * * * cd /var/www/html; /usr/local/bin/php -f cron.php > /dev/null 2>&1' | crontab -

CMD service cron start && apache2-foreground
