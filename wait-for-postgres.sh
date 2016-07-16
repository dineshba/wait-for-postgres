#!/usr/bin/env bash
#   Use this script to test if a given TCP host/port are available
# upstream at https://github.com/vishnubob/wait-for-it

cmdname=$(basename $0)

DEFAULT_HOST="localhost"
DEFAULT_PORT="5432"
DEFAULT_USER="postgres"
DEFAULT_PASS="postgres"
DEFAULT_DBNAME="postgres"
DEFAULT_STATEMENT="select 1"
DEFAULT_TIMEOUT=300
DEFAULT_WAIT=30

usage()
{
    cat << USAGE >&2
Usage:
    $cmdname -h host -p port -U user -W pass -d DBNAME [-t timeout]
    -h HOST | --host=HOST                   Host or IP under test
    -p PORT | --port=PORT                   TCP port under test
                                            Alternatively, you specify the host and port as host:port
    -U USER | --username=USER               The user to connect to psql
    -W PASS | --password=PASS               The password for the user
    -d DBNAME | --dbname=DBNAME             The database to connect to
    -t TIMEOUT | --timeout=timeout          Timeout in seconds, zero for no timeout
    -s STATEMENT | --statement=STATEMENT    SQL statement to execute
    -w WAIT | --wait=WAIT                   Number of seconds to wait until second connection attempt
USAGE
    exit 1
}

while [[ $# -gt 0 ]]
do
    case "$1" in
        -d)
            DBNAME="$2"
            if [[ $DBNAME == "" ]]; then break; fi
            shift 2
            ;;
        --dbname=*)
            DBNAME="${1#*=}"
            shift 1
            ;;
        -h)
            HOST="$2"
            if [[ $HOST == "" ]]; then break; fi
            shift 2
            ;;
        --host=*)
            HOST="${1#*=}"
            shift 1
            ;;
        -U)
            USER="$2"
            if [[ $USER == "" ]]; then break; fi
            shift 2
            ;;
        --username=*)
            USER="${1#*=}"
            shift 1
            ;;
        -W)
            PASS="$2"
            if [[ $PASS == "" ]]; then break; fi
            shift 2
            ;;
        --password=*)
            PASS="${1#*=}"
            shift 1
            ;;
        -p)
            PORT="$2"
            if [[ $PORT == "" ]]; then break; fi
            shift 2
            ;;
        --port=*)
            PORT="${1#*=}"
            shift 1
            ;;
        -s)
            STATEMENT="$2"
            if [[ $STATEMENT == "" ]]; then break; fi
            shift 2
            ;;
        --statement=*)
            STATEMENT="${1#*=}"
            shift 1
            ;;
        -t)
            TIMEOUT="$2"
            if [[ $TIMEOUT == "" ]]; then break; fi
            shift 2
            ;;
        --timeout=*)
            TIMEOUT="${1#*=}"
            shift 1
            ;;
        -w)
            WAIT="$2"
            if [[ $WAIT == "" ]]; then break; fi
            shift 2
            ;;
        --wait=*)
            WAIT="${1#*=}"
            shift 1
            ;;
        --help)
            usage
            ;;
        *)
            echoerr "Unknown argument: $1"
            usage
            ;;
    esac
done


if [[ "$HOST" == "" ]]; then
    HOST="$DEFAULT_HOST"
fi
if [[ "$PORT" == "" ]]; then
    PORT="$DEFAULT_PORT"
fi
if [[ "$USER" == "" ]]; then
    USER="$DEFAULT_USER"
fi
if [[ "$PASS" == "" ]]; then
    PASS="$DEFAULT_PASS"
fi
if [[ "$DBNAME" == "" ]]; then
    DBNAME="$DEFAULT_DBNAME"
fi
if [[ "$STATEMENT" == "" ]]; then
    STATEMENT="$DEFAULT_STATEMENT"
fi
if [[ "$TIMEOUT" == "" ]]; then
    TIMEOUT="$DEFAULT_TIMEOUT"
fi
if [[ "$WAIT" == "" ]]; then
    WAIT="$DEFAULT_WAIT"
fi

echo "HOST: $HOST"
echo "PORT: $PORT"
echo "USER: $USER"
echo "PASS: $PASS"
echo "DBNAME: $DBNAME"
echo "STATEMENT: $STATEMENT"
echo "TIMEOUT: $TIMEOUT"
echo "WAIT: $WAIT"
