FROM schoeffm/rpi-nginx-php5

WORKDIR /usr/share/nginx

RUN apt-get update && \
    apt-get install -y php5-sqlite mysql-client vim pkg-config ca-certificates git-core inetutils-ping  --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV commit_id f037be63cc0be2dde16b37fa78a0f84ac5af488c

RUN git clone https://github.com/Ysurac/FlightAirMap.git && \
    cd FlightAirMap && \
    git reset --hard $commit_id

RUN chown -R www-data /usr/share/nginx/FlightAirMap

COPY nginx_host.conf /etc/nginx/sites-enabled/nginx_host.conf

RUN rm /etc/nginx/sites-enabled/default

COPY settings.php /usr/share/nginx/FlightAirMap/require/settings.php

COPY startup.sh /opt/startup.sh

CMD /opt/startup.sh
