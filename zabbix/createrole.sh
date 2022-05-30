#!/bin/sh

URL='http://192.168.15.136/zabbix/api_jsonrpc.php'
HEADER='Content-Type:application/json'

USER='"Admin"'
PASS='"zabbix"'

autenticacao()
{
    JSON='
    {
        "jsonrpc": "2.0",
        "method": "user.login",
        "params": {
            "user": '$USER',
            "password": '$PASS'
        },
        "id": 0
    }
    '
    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | cut -d '"' -f8
}
TOKEN=$(autenticacao)

creater_role()
{
    JSON='
{
    "jsonrpc": "2.0",
    "method": "role.create",
    "params": {
        "name": "Grafana",
        "type": "1",
        "rules": {
            "ui": [
                {
                    "name": "monitoring.hosts",
                    "status": "0"
                },
                {
                    "name": "monitoring.maps",
                    "status": "0"
                }
            ]
        }
    },
    "auth": "cd23d1e73deff0f6b16bffe2bbce6119cafec0540c95d70146dccbb55b097bda",
    "id": 1
}
    '
    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" > /dev/null
}

create_role
echo "Role criado com sucesso."
