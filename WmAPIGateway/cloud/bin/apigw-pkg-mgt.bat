@echo off
rem  ###########################################################################
rem                                                                            #
rem  apigw-pkg-mgt.bat                                                        #
rem                                                                            #
rem  This script is designed to work with Java VM's that conform to the        #
rem  command-line conventions of Sun Microsystems (TM) Java Development Kit    #
rem  or Java Runtime Environment.                                              #
rem                                                                            #
rem  ###########################################################################

SET CURR_DIR=%~dp0

IF "%JRE_HOME%" == "" (
    set JAVA_EXE="%CURR_DIR%\..\..\..\..\..\..\..\jvm\jvm\jre\bin\java"
) ELSE (
    SET JAVA_EXE="%JRE_HOME%\bin\java"
)

SET CLASSPATH=""
SET CLASSPATH=%CURR_DIR%..\..\code\jars\apigateway-utility.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\..\code\jars\ant-1.8.2.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\..\code\jars\ant-launcher-1.8.2.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\lib\log4j-1.2.17.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\lib\httpclient-4.5.2.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\lib\httpcore-4.4.4.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\lib\httpmime-4.5.1.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\lib\commons-logging-1.1.1.jar;%CLASSPATH%

%JAVA_EXE% com.softwareag.apigateway.utility.command.ispackage.manage.ManagePackage %*
