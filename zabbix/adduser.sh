#!/bin/sh
# Script para cadastrar User.

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

criar_user()
{
    JSON='
    {
        "jsonrpc": "2.0",
        "method": "user.create",
        "params": {
        "username": "Andrade",
        "passwd": "2127_anD",
        "roleid": "1",
        "usrgrps": [
            {
                "usrgrpid": "8"
            }
        ],
        "medias": [
            {
                "mediatypeid": "1",
                "sendto": [
                    "support@company.com"
                ],
                "active": 0,
                "severity": 63,
                "period": "1-7,00:00-24:00"
            }
        ]
    },
    "auth": "4fcfa7710d26919bd15b6007dbd731a4ab89f4aa2eb45439a936c5312d6c9ec3",
    "id": 3
}
    '
    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" > /dev/null
}

criar_user
echo "User criado com sucesso."
