@echo off
set DIRNAME=%~dp0

ECHO %DIRNAME%

IF EXIST %DIRNAME%..\..\..\..\..\instances (
    set ROOT_DIR=%DIRNAME%..\..\..\..\..\..
) ELSE (
    set ROOT_DIR=%DIRNAME%..\..\..\..
)

set IS_DIR=%ROOT_DIR%\IntegrationServer
set JVM_DIR=%ROOT_DIR%\jvm\jvm

set IS_INSTANCE_DIR=%DIRNAME%\..\..\..

set DEP_INSTANCE_PACKAGE=%DIRNAME%\..

IF [%1]==[] ( echo "Please provide an input XML file. For information on how to create the XML file please refer to documentation" ) ELSE ( "%JVM_DIR%\bin\java" -Dserver.install.dir=%IS_INSTANCE_DIR% -Dlog4j.configurationFile=%DIRNAME%\log4j2.xml -classpath "%IS_DIR%\..\common\lib\ext\activation.jar;%IS_DIR%\..\common\lib\glassfish\gf.webservices-api-osgi.jar;%IS_DIR%\lib\wm-isserver.jar;%DEP_INSTANCE_PACKAGE%\lib\CLI.jar;%DEP_INSTANCE_PACKAGE%\lib\projectautomator.jar;%DEP_INSTANCE_PACKAGE%\code\classes;%IS_DIR%\..\common\lib\ext\commons-cli.jar;%IS_DIR%\..\common\lib\wm-isclient.jar;%IS_DIR%\..\common\lib\glassfish\gf.jakarta.mail.jar;%IS_DIR%\..\common\lib\ext\xml-apis.jar;%IS_DIR%\..\common\lib\ext\xercesImpl.jar;%IS_DIR%\..\common\lib\ext\log4j\*;%IS_DIR%\..\common\lib\ext\enttoolkit.jar;%IS_DIR%\..\common\lib\wm-scg-security.jar;%IS_DIR%\..\common\lib\wm-scg-core.jar;%IS_DIR%\..\common\lib\wm-g11nutils.jar" com.softwareag.webm.deployer.automation.MainClass %* %DEP_INSTANCE_PACKAGE%\config\ProjectAutomatorForRuntime.xsd %DEP_INSTANCE_PACKAGE%\config\ProjectAutomatorForRepository.xsd 1)

set returnValue=%ERRORLEVEL%
IF %returnValue% NEQ 0 echo Error Code = %returnValue%
exit /b %returnValue%