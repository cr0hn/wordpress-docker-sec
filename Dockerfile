FROM wordpress:fpm

COPY remove_metas_and_versions.txt /etc
COPY change_statics_signature.sh /usr/local/bin
COPY hardenize-and-run.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/change_statics_signature.sh
RUN chmod +x /usr/local/bin/hardenize-and-run.sh

ENTRYPOINT ["hardenize-and-run.sh"]
CMD ["php-fpm"]