@echo off
rem  ###########################################################################
rem  
rem  apigw-restore-tenant.bat
rem  
rem  This script is designed to work with Java VM's that conform to the
rem  command-line conventions of Sun Microsystems (TM) Java Development Kit
rem  or Java Runtime Environment.
rem  
rem  ###########################################################################

SET CURR_DIR=%~dp0

CALL %CURR_DIR%apigw-setenv.bat

echo Note: This command has been deprecated. Please use apigatewayUtil instead
echo.

%JAVA_EXE% com.softwareag.apigateway.utility.command.restore.instance.RestoreApiGatewayInstance %*
