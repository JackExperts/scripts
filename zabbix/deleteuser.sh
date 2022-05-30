#!/bin/sh
# Script para cadastrar hosts.

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

deletar_user()
{
    JSON='
{
    "jsonrpc": "2.0",
    "method": "user.delete",
    "params": ["9"],
    "auth": "cd23d1e73deff0f6b16bffe2bbce6119cafec0540c95d70146dccbb55b097bda",
    "id": 1
}
    '
    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" > /dev/null
}

deletar_user
echo "User Deletado com sucesso."
