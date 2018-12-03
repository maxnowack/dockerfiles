#!/bin/bash
set -e

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "Checking MySQL connection..."
dbstatus=2
retrycount=1
maxretry=20
set +e

until [ $dbstatus -eq 0 ]
  do
  if [ $retrycount -gt $maxretry ]; then
    echo "${red}failed to connect to database - pleas check your credentials${reset}"
    exit 1
  fi
  echo "Try $retrycount of $maxretry..."
  mysql -h ${FLIGHT_DB_HOST} --user=$FLIGHT_DB_USER --password=$FLIGHT_DB_PASS -e exit 2>/dev/null
  dbstatus=`echo $?`
  retrycount=$[$retrycount+1]
  sleep 5
done
set -e

echo "${green}Database connection ok${reset}"
echo "Checking for database"

set +e
mysqlshow -h${FLIGHT_DB_HOST} -u${FLIGHT_DB_USER} -p${FLIGHT_DB_PASS} ${FLIGHT_DB_NAME} > /dev/null
tablestatus=`echo $?`
set -e

if [ $tablestatus -ne 0 ]; then
  echo "${red}Database ${FLIGHT_DB_NAME} not found${reset}"
  exit 1
else
  echo "${green}Database found${reset}"
fi

echo "Checking if database is populated"
set +e
mysqlshow -h${FLIGHT_DB_HOST} -u${FLIGHT_DB_USER} -p${FLIGHT_DB_PASS} ${FLIGHT_DB_NAME} "acars\_archive" > /dev/null
tablestatus=`echo $?`
set -e


# Function to update the fpm configuration to make the service environment variables available
function setEnvironmentVariable() {

    if [ -z "$2" ]; then
            echo "Environment variable '$1' not set."
            return
    fi

    # Check whether variable already exists
    if grep -q $1 /etc/php5/fpm/pool.d/www.conf; then
        # Reset variable
        sed -i 's/^env\[$1.*/env[$1] = $2/g' /etc/php5/fpm/pool.d/www.conf
    else
        # Add variable
        echo "env[$1] = '$2'" >> /etc/php5/fpm/pool.d/www.conf
    fi
}

for _curVar in `env | grep FLIGHT_ | awk -F = '{print $1}'`;do
    # awk has split them by the equals sign
    # Pass the name and value to our function
    setEnvironmentVariable ${_curVar} ${!_curVar}
done

if [ $tablestatus -ne 0 ]; then
  echo "${red}Database is empty${reset}"
  echo "Configuring database, this will take several minutes!"
  cd /usr/share/nginx/FlightAirMap/install
  php install_db.php
else
  echo "${green}Database already populated${reset}"
fi

echo "Starting sbs service..."
start-stop-daemon --background --start --exec /usr/share/nginx/FlightAirMap/cron-sbs.php

echo "Starting acars service..."
start-stop-daemon --background --start --exec /usr/share/nginx/FlightAirMap/cron-acars.php

echo "Starting webservice..."
service php5-fpm start
nginx
