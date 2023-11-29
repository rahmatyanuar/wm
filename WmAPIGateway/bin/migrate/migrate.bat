@echo off
rem  ###########################################################################
rem                                                                            #
rem  migration.bat : Migrate webMethods API Gateway 10.0 to 10.1               #
rem                                                                            #
rem  This script is designed to work with Java VM's that conform to the        #
rem  command-line conventions of Sun Microsystems (TM) Java Development Kit    #
rem  or Java Runtime Environment.                                              #
rem                                                                            #
rem  ###########################################################################

SETLOCAL

SET IS_DIR=%~dp0..\..\..\..\..\..
SET PKG_DIR=%~dp0..\..

SET JAVA_MIN_MEM=256M
SET JAVA_MAX_MEM=1024M

rem  ################################

SET GLOBAL_SETENV=%IS_DIR%\..\install\bin\setenv.bat

IF EXIST "%GLOBAL_SETENV%" (
    call "%GLOBAL_SETENV%"
)

IF "%JRE_HOME%" == "" (
    set JAVA_EXE="%IS_DIR%\..\jvm\jvm\jre\bin\java"
) ELSE (
    SET JAVA_EXE="%JRE_HOME%\bin\java"
)

set SAVED_CP=%CLASSPATH%

set CLASSPATH="%PKG_DIR%\code\jars\apigateway-migration.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\migration\lib\*"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\cli\lib\*"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-utility.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\json-path-2.2.0.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\json-smart-2.2.1.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\static\*"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\*"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\lib\ext\spring-context.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\lib\ext\spring-core.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\lib\ext\spring-beans.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\lib\ext\spring-expression.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\lib\ext\commons-logging.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\lib\*"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\lib\ext\*"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-core.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-is.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-api-import.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-runtime.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-runtime-base.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-iam.jar"
set CLASSPATH=%CLASSPATH%;"%PKG_DIR%\code\jars\apigateway-iam-base.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\runtime\bundles\cel\eclipse\plugins\*"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\runtime\bundles\ext\eclipse\plugins\*"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\common\runtime\bundles\wss\eclipse\plugins\*"
set CLASSPATH=%CLASSPATH%;"%~dp0\*"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\..\WS-Stack\lib\synapse-core-2.1.0.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\lib\wm-isserver.jar"
set CLASSPATH=%CLASSPATH%;"%IS_DIR%\lib\jars\nimbus-jose-jwt-8.5.1.jar"


title webMethods API Gateway Migration Utility

%JAVA_EXE% -Dwatt.migration.server.homeDir="%IS_DIR%" -Dwatt.migration.server.pkgDir="%PKG_DIR%" -ms%JAVA_MIN_MEM% -mx%JAVA_MAX_MEM% -classpath %CLASSPATH% com.softwareag.apigateway.migration.core.MigrationCore %*

set EL=%ERRORLEVEL%

rem 
rem restore original classpath 
rem
set CLASSPATH=%SAVED_CP%
GOTO end

:end
ENDLOCAL
EXIT /B %EL%
