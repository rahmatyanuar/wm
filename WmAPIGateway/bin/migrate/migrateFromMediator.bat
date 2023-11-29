@echo off
rem #=========================================================================
rem #
rem # Migrate required Mediator files to API Gateway
rem #
rem # Usage:
rem # migrateFromMediator.bat IntegrationServer-root-directory instance-name
rem #
rem # Example:
rem # migrateFromMediator.bat C:\SoftwareAG\IntegrationServer default
rem #
rem #=========================================================================

SETLOCAL

IF "%1" == "" GOTO usage
IF "%2" == "" GOTO usage

SET IS_DIR=%1\instances\%2\packages\WmMediator
ECHO IS_DIR %IS_DIR%
IF NOT EXIST %IS_DIR% GOTO usage
SET IS_RES_DIR=%IS_DIR%\config\resources

SET APIGW_DIR=%~dp0
ECHO APIGW_DIR %APIGW_DIR%
SET APIGW_MED_DIR=%APIGW_DIR%\mediator
IF NOT EXIST %APIGW_MED_DIR% MKDIR %APIGW_MED_DIR%

COPY /Y %IS_RES_DIR%\pg-config.properties %APIGW_MED_DIR%
SET EL=%ERRORLEVEL%
IF /I "%EL%" NEQ "0" GOTO end

COPY /Y %IS_RES_DIR%\serviceConfig.xml %APIGW_MED_DIR%
SET EL=%ERRORLEVEL%
IF /I "%EL%" NEQ "0" GOTO end

GOTO end

:usage
ECHO migrateFromMediator.bat IntegrationServer-root-directory instance-name
ECHO Example:
ECHO migrateFromMediator.bat C:\SoftwareAG\IntegrationServer default
SET EL=1

:end
ENDLOCAL
EXIT /B %EL%
