FROM wordpress:5-php7.3-fpm

RUN apt-get update && apt-get install libphp-predis && \
    pecl install apcu-beta && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini && docker-php-ext-enable apcu && \
    pecl install redis && echo extension=redis.so > /usr/local/etc/php/conf.d/redis.ini && docker-php-ext-enable redis

COPY remove_metas_and_versions.txt /etc
COPY remove_php_warnings.txt /etc
COPY change_statics_signature.sh /usr/local/bin
COPY hardenize-and-run.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/change_statics_signature.sh
RUN chmod +x /usr/local/bin/hardenize-and-run.sh

# Install wp admin tool
#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
#    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["hardenize-and-run.sh"]
CMD ["php-fpm"]