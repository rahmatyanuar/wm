#!/bin/bash

DATE=$(date +%Y-%m-%d-%H%M)

mkdir -p logs
LOG_FILE=logs/archive-metrics-"$DATE".log

exec > >(tee -a -i "$LOG_FILE")
exec 2>&1

echo
date
echo

echo "$(date -Iseconds) : $0 script has been invoked with arguments $* from location $PWD "
echo "All the log file data available at ${PWD}/logs/archive-analyticmetrics.log"

echo -e "API Gateway Metrics Archiving and Purging initiated.."

CLOUD_BIN_SCRIPTS_DIR="$PWD"
ROOT_SCRIPTS_DIR=$(dirname $(dirname "$PWD"))
CLI_BIN_SCRIPTS_DIR="$ROOT_SCRIPTS_DIR"/cli/bin

echo "Value of CLOUD_BIN_SCRIPTS_DIR is $CLOUD_BIN_SCRIPTS_DIR"
echo "Value of CLI_BIN_SCRIPTS_DIR is $CLI_BIN_SCRIPTS_DIR"


error_count=0


echo -e "Total error count is $error_count"


if (($error_count > 0)); then
    echo -e "Please refer help for script $0 -help"
    echo "Exiting the script due to input error."
    exit 1
fi

echo "${CLI_BIN_SCRIPTS_DIR}/apigatewayUtil.sh create archive"

bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh create archive
EXIT_CODE=$?
echo "EXIT_CODE of archiving process is $EXIT_CODE"

if (($EXIT_CODE > 0)); then
    echo
    echo "Archiving & Purge process for customer ${tenantName} FAILED.. Please look into it.."
    date
    exit 1
else
    echo
    echo -e "Analytic metrics archiving and purging of metrics and snapshots are complete - SUCCESSFULLY.."
fi
