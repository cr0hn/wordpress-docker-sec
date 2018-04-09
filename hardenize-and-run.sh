#!/usr/bin/env bash

#
# Remove the line: exec "$@"
#
grep -vi "exec \"\$\@\"" /usr/local/bin/docker-entrypoint.sh > /tmp/kk
mv /tmp/kk /usr/local/bin/docker-entrypoint.sh
chmod +x /usr/local/bin/docker-entrypoint.sh

echo "[*] Running original entry point"
docker-entrypoint.sh $1

# Remove metas and versions from statics
cat /var/www/html/wp-includes/functions.php | grep -i hide_wordpress_version_in_script > /tmp/already_exist.txt
if [ ! -s /tmp/already_exist.txt  ]; then
    echo "[*] Removing metas"
    cat /etc/remove_metas_and_versions.txt >> /var/www/html/wp-includes/functions.php
fi
rm -rf /tmp/already_exist.txt

# Remove Versions from default themes
echo "[*] Removing versions from statics"
change_statics_signature.sh

# Remove PHP warnings
echo "[*] Removing PHP Warnings"
cat /etc/remove_php_warnings.txt >> /var/www/html/wp-config.php

exec "$@"