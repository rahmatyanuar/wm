#!/bin/sh

#=========================================================================
#
# Migrate required Mediator files to API Gateway
#
# Usage:
# ./migrateFromMediator.sh IntegrationServer-root-directory instance-name
#
# Example:
# ./migrateFromMediator.sh /opt/softwareag/IntegrationServer default
#
#=========================================================================

APIGW_DIR=`dirname $0`
cd ${APIGW_DIR}

usage(){
	echo "./migrateFromMediator.sh IntegrationServer-root-directory instance-name"
	echo "Example:"
	echo "./migrateFromMediator.sh /opt/softwareag/IntegrationServer default"
	exit 1
}

if [ $# -lt 2 ]
then
    usage
fi

IS_DIR="$1/instances/$2/packages/WmMediator"
echo "IS_DIR ${IS_DIR}"
if [ ! -d ${IS_DIR} ]
then
	usage
fi	
IS_RES_DIR=${IS_DIR}/config/resources

echo "APIGW_DIR ${APIGW_DIR}"
if [ ! -d ${APIGW_DIR}/mediator ]
then
	mkdir ${APIGW_DIR}/mediator
fi	

cp ${IS_DIR}/config/resources/pg-config.properties ${APIGW_DIR}/mediator
rc=$?
if [ $rc -ne 0 ]
then
	exit $rc
fi		

cp ${IS_DIR}/config/resources/serviceConfig.xml ${APIGW_DIR}/mediator
rc=$?
if [ $rc -ne 0 ]
then
	exit $rc
fi		

exit $rc
