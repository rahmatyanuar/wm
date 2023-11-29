#!/bin/sh
##############################################################################
#                                                                            #
#   apigw-pkg-mgt.bat                                                        #
#                                                                            #
#  This script is designed to work with Java VM's that conform to the        #
#  command-line conventions of Sun Microsystems (TM) Java Development Kit    #
#  or Java Runtime Environment.                                              #
#                                                                            #
##############################################################################

cd `dirname $0`
SCRIPTDIR=`pwd`

if [ "x$JRE_HOME" = "x" ]; then
    JAVA_EXE=$SCRIPTDIR/../../../../../../../jvm/jvm/jre/bin/java
else
    JAVA_EXE=$JRE_HOME/bin/java
	
if [ `uname -s` = "HP-UX" ]; then
    JAVA_RUN="${JAVA_EXE} ${JAVA_MEMSET} ${JAVA_ARG1}"
else
    JAVA_RUN="${JAVA_EXE} ${JAVA_MEMSET}"
fi

CLASSPATH=""
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../../code/jars/apigateway-utility.jar"
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../../code/jars/ant-1.8.2.jar"
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../../code/jars/ant-launcher-1.8.2.jar"
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../lib/log4j-1.2.17.jar"
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../lib/httpclient-4.5.2.jar"
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../lib/httpcore-4.4.4.jar"
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../lib/httpmime-4.5.1.jar"
CLASSPATH=${CLASSPATH}:"$SCRIPTDIR/../lib/commons-logging-1.1.1.jar"

$JAVA_RUN -classpath $CLASSPATH com.softwareag.apigateway.utility.command.ispackage.manage.ManagePackage $*