@echo off
rem  ###########################################################################
rem  
rem  apigw-setenv.bat
rem  
rem  This script is designed to work with Java VM's that conform to the
rem  command-line conventions of Sun Microsystems (TM) Java Development Kit
rem  or Java Runtime Environment.
rem  
rem  ###########################################################################

IF "%JRE_HOME%" == "" (
    set JAVA_EXE="%CURR_DIR%\..\..\..\..\..\..\..\jvm\jvm\bin\java"
) ELSE (
    SET JAVA_EXE="%JRE_HOME%\bin\java"
)

SET IS_DIR=%CURR_DIR%..\..\..\..\..\..\
SET COMMON_LIB_DIR=%IS_DIR%..\common\lib

SET CLASSPATH=;%CURR_DIR%..\..\code\jars\*;%CURR_DIR%..\..\code\jars\static\*;%COMMON_LIB_DIR%\ext\*
