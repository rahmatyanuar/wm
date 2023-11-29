FOR /F "TOKENS=1 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET dd=%%A
FOR /F "TOKENS=1,2 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET mm=%%B
FOR /F "TOKENS=1,2,3 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET yyyy=%%C
SET DATE=%yyyy%-%mm%-%dd%

mkdir logs
SET LOG_FILE=logs/archive-metrics-%DATE%.log

call :LOG > %LOG_FILE%
exit /b

:LOG
echo
date
echo

echo "$(date -Iseconds) : $0 script has been invoked with arguments $* from location $PWD "
echo "All the log file data available at %cd%/logs/archive-analyticmetrics.log"

echo -e "API Gateway Metrics Archiving initiated.."

SET CLOUD_BIN_SCRIPTS_DIR=%cd%
SET ROOT_SCRIPTS_DIR=%cd%/../..
SET CLI_BIN_SCRIPTS_DIR=%ROOT_SCRIPTS_DIR%/cli/bin

echo "Value of CLOUD_BIN_SCRIPTS_DIR is %CLOUD_BIN_SCRIPTS_DIR%"
echo "Value of CLI_BIN_SCRIPTS_DIR is %CLI_BIN_SCRIPTS_DIR%"

#java name
UTIL_JARS="%cd%/../.."
TENANT_DIR="%cd%/../../../.."
JAR_DIR="%TENANT_DIR%/packages/WmAPIGateway/code/jars"

CLI="$(dirname $PWD)"
JAVA_DIR="%TENANT_DIR%/../../../jvm/jvm"
IS_DIR=""%TENANT_DIR%/../../.."

for %file in (%JAR_DIR%/*.jar) do
    SET CLASSPATH=%file%;%CLASSPATH%
done
for %file in (%CLI%/lib/*.jar) do
    SET CLASSPATH=%file%;%CLASSPATH%
done
for %file in $(ls $JAR_DIR/static/jackson*.jar); do
    SET CLASSPATH=%file%;%CLASSPATH%
done

for %file in (%UTIL_JARS%/cloud/lib/*.jar) do
    SET CLASSPATH=%file%;%CLASSPATH%
done

#CLASSPATH=%CLASSPATH%/../lib/aws-java-sdk-s3-1.11.204.jar

#export CLASSPATH

SET JAVA_EXE="%JAVA_DIR%/bin/java"

SET error_count=0




echo -e "Total error count is %error_count%"


if ((error_count > 0)); then
    echo -e "Please refer help for script $0 -help"
    echo "Exiting the script due to input error."
    exit 1
fi



call %CLI_BIN_SCRIPTS_DIR%/apigatewayUtil.bat archive -debug true -sync true
SET EXIT_CODE=%errorlevel%
echo "EXIT_CODE of archiving process is %EXIT_CODE%"

if ((%EXIT_CODE% > 0)); then
    echo
    echo "Archiving process for customer %tenantName% FAILED.. Please look into it.."
    date
    exit 1
else
    echo
    echo -e "Analytic metrics archiving is complete - SUCCESSFULLY.."
fi
