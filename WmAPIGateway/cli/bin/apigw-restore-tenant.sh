#!/bin/sh
#=============================================================================
#
#  apigw-restore-tenant.sh
#
#=============================================================================

CURR_DIR="$PWD"
. $CURR_DIR/apigw-setenv.sh

CLASS="com.softwareag.apigateway.utility.command.restore.instance.RestoreApiGatewayInstance"

echo "Note: This command has been deprecated. Please use apigatewayUtil instead"
echo ""

EXECUTABLE="${JAVA_EXE} -cp ${CLASSPATH} ${CLASS}"
$EXECUTABLE "$@"
returnCode=$?

exit $returnCode

