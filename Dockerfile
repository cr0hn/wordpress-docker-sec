FROM wordpress:fpm

RUN apt-get update && apt-get install libphp-predis && \
    pecl install apcu-beta && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini && docker-php-ext-enable apcu && \
    pecl install redis && echo extension=redis.so > /usr/local/etc/php/conf.d/redis.ini && docker-php-ext-enable redis

COPY remove_metas_and_versions.txt /etc
COPY remove_php_warnings.txt /etc
COPY change_statics_signature.sh /usr/local/bin
COPY hardenize-and-run.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/change_statics_signature.sh
RUN chmod +x /usr/local/bin/hardenize-and-run.sh

ENTRYPOINT ["hardenize-and-run.sh"]
CMD ["php-fpm"]