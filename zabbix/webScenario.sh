#!/bin/sh
# Author: Ruan Carlos - ruan@jackexperts.com

API=${ZABBIX_URL}
ZABBIX_USER=${ZABBIX_USER}
ZABBIX_PASS=${ZABBIX_PASSWORD}

authenticate()
{
    wget --no-check-certificate -O- -o /dev/null $API --header 'Content-Type: application/json' --post-data "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"user.login\",
        \"params\": {
                \"user\": \"$ZABBIX_USER\",
                \"password\": \"$ZABBIX_PASS\"},
        \"auth\": null,
        \"id\": 1}" | cut -d'"' -f8
}
AUTH_TOKEN=$(authenticate)

echo "$AUTH_TOKEN"

webscenario_create()
{
    wget --no-check-certificate -O- -o /dev/null $API --header 'Content-Type: application/json' --post-data "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"httptest.create\",
        \"params\": {
        \"name\": \"$WEB_NAME\",
        \"hostid\": \"$WEB_HOST_ID\",
        \"steps\": [
            {
                \"name\": \"$WEB_NAME\",
                \"url\": \"$WEB_URL\",
                \"status_codes\": \"$WEB_CODE\",
                \"no\": 1
            }
        ]
    },
        \"auth\": \"$AUTH_TOKEN\",
        \"id\": 2}"
}

webscenario_delete()
{
    wget --no-check-certificate -O- -o /dev/null $API --header 'Content-Type: application/json' --post-data "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"httptest.delete\",
        \"params\": [\"$WEB_ID\"],
        \"auth\": \"$AUTH_TOKEN\",
        \"id\": 2}"
}

WEB=$($1);
echo "$WEB"
