#!/bin/sh

#############################################################################
#                                                                           #
# migration.sh : Migrate webMethods API Gateway 10.0 to 10.1                #
#                                                                           #
#############################################################################

cd `dirname $0`
SCRIPTDIR=`pwd`

IS_DIR=${SCRIPTDIR}/../../../../../..
PKG_DIR=${SCRIPTDIR}/../..

JAVA_MIN_MEM=256M
JAVA_MAX_MEM=1024M

DIRNAME=$IS_DIR/bin

# Read the configuration file
if [ "x$RUN_CONF" = "x" ]; then
    RUN_CONF="${DIRNAME}/setenv.sh"
fi

if [ -r "$RUN_CONF" ]; then
    . "$RUN_CONF"
fi

GLOBAL_SETENV=${IS_DIR}/../install/bin/setenv.sh
if [ -r "$GLOBAL_SETENV" ]; then
    . "$GLOBAL_SETENV"
fi

## ---- BE CAREFUL MAKING ANY CHANGES BELOW THIS LINE ----

JAVA_OPT_80_AUDIT_TBLS="-Dcom.webmethods.sc.auditing.Use80TableFormat=true" 

ALLOW_ARRAY_CLASSLOADING="-Dsun.lang.ClassLoader.allowArraySyntax=true"

##
## ---- BE CAREFUL MAKING ANY CHANGES BELOW THIS LINE ----
##

## ---- JAVA VM SETUP ----

if [ "x$JRE_HOME" = "x" ]; then
    JAVA_EXE=$IS_DIR/../jvm/jvm/jre/bin/java
else
    JAVA_EXE=$JRE_HOME/bin/java
fi

if [ `uname -s` = "HP-UX" ]; then
    JAVA_RUN="${JAVA_EXE} ${JAVA_MEMSET} ${JAVA_ARG1}"
else
    JAVA_RUN="${JAVA_EXE} ${JAVA_MEMSET}"
fi

##	SAVE PATHS TO BE RESTORED WHEN FINISHED

SAVED_CP=${CLASSPATH}
SAVED_LD=${LD_LIBRARY_PATH}

## NOTE: for HP-UX 
SAVED_HP=${SHLIB_PATH}

## NOTE: for AIX 
SAVED_AIX=${LIBPATH}


## GATHER ARGUMENTS 

CLASSPATH="$PKG_DIR/code/jars/apigateway-migration.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/migration/lib/*"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/cli/lib/*"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-utility.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/json-path-2.2.0.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/json-smart-2.2.1.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/static/*"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/spring-context.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/spring-core.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/spring-beans.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/spring-expression.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/commons-logging.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/*"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-core.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-is.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-api-import.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-runtime.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-runtime-base.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-iam.jar"
CLASSPATH=${CLASSPATH}:"$PKG_DIR/code/jars/apigateway-iam-base.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/runtime/bundles/cel/eclipse/plugins/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/runtime/bundles/ext/eclipse/plugins/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/runtime/bundles/wss/eclipse/plugins/*"
CLASSPATH=${CLASSPATH}:"${SCRIPTDIR}/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../WS-Stack/lib/synapse-core-2.1.0.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/lib/wm-isserver.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/lib/jars/nimbus-jose-jwt-8.5.1.jar"

echo ""
echo "webMethods API Gateway Migration Utility"
echo ""

$JAVA_RUN $JAVA_D64 -Dwatt.migration.server.homeDir=$IS_DIR -Dwatt.migration.server.pkgDir=$PKG_DIR -ms$JAVA_MIN_MEM -mx$JAVA_MAX_MEM -classpath $CLASSPATH com.softwareag.apigateway.migration.core.MigrationCore $*

rc=$?

## RESET SAVED PATHS

CLASSPATH=${SAVED_CP}
LD_LIBRARY_PATH=${SAVED_LD}

export CLASSPATH
export LD_LIBRARY_PATH

# reset only if not empty
if [ -n "${SAVED_HP}" ]; then
    SHLIB_PATH=${SAVED_HP}
    export SHLIB_PATH
fi

# reset only if not empty
if [ -n "${SAVED_AIX}" ]; then
    LIBPATH=${SAVED_AIX}
    export LIBPATH
fi

exit $rc
