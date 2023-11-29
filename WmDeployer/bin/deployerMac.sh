#!/bin/sh

# Change IS_DIR and JVM_DIR to reflect their locations on your system
# Note: The JVM must have the JCE extension
# 
# --- LOCATION OF WEBMETHODS INTEGRATION SERVER ---

DIRNAME=`dirname $0`

if [ -d $DIRNAME/../../../../../instances ]; then
	ROOT_DIR=$DIRNAME/../../../../../..
else
	ROOT_DIR=$DIRNAME/../../../..
fi

IS_DIR=$ROOT_DIR/IntegrationServer
JVM_DIR=$ROOT_DIR/jvm/jvm
DEP_INSTANCE_PACKAGE=$DIRNAME/..

export IS_DIR
export JVM_DIR
export DEP_INSTANCE_PACKAGE

if [ -z "$1" ]
then
	${JVM_DIR}/bin/java -Dlog4j.configurationFile=${DIRNAME}/log4j2.xml -classpath "${IS_DIR}/../common/lib/wm-scg-security.jar:${IS_DIR}/../common/lib/wm-scg-core.jar:${DEP_INSTANCE_PACKAGE}/lib/CLI.jar:${DEP_INSTANCE_PACKAGE}/code/classes:${IS_DIR}/../common/lib/ext/commons-cli.jar:${IS_DIR}/../common/lib/wm-isclient.jar:${IS_DIR}/../common/lib/glassfish/gf.jakarta.mail.jar:${IS_DIR}/../common/lib/ext/log4j/*:${IS_DIR}/../common/lib/ext/enttoolkit.jar:${DEP_INSTANCE_PACKAGE}/bin" com.wm.deployer.CLI.MainClass "--usage"
else
${JVM_DIR}/bin/java -Dlog4j.configurationFile=${DIRNAME}/log4j2.xml -classpath "${IS_DIR}/../common/lib/wm-scg-security.jar:${IS_DIR}/../common/lib/wm-scg-core.jar:${DEP_INSTANCE_PACKAGE}/lib/CLI.jar:${DEP_INSTANCE_PACKAGE}/code/classes:${IS_DIR}/../common/lib/ext/commons-cli.jar:${IS_DIR}/../common/lib/wm-isclient.jar:${IS_DIR}/../common/lib/glassfish/gf.jakarta.mail.jar:${IS_DIR}/../common/lib/ext/log4j/*:${IS_DIR}/../common/lib/ext/enttoolkit.jar:${DEP_INSTANCE_PACKAGE}/bin" com.wm.deployer.CLI.MainClass "$@"
fi