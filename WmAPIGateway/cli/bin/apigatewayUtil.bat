@echo off
rem  ###########################################################################
rem                                                                            #
rem  apigatewayUtil.bat                                                        #
rem                                                                            #
rem  This script is designed to work with Java VM's that conform to the        #
rem  command-line conventions of Sun Microsystems (TM) Java Development Kit    #
rem  or Java Runtime Environment.                                              #
rem                                                                            #
rem  ###########################################################################



SET CURR_DIR=%~dp0


if "%1" == "-help" (goto usage)


IF "%JRE_HOME%" == "" (
    set JAVA_EXE="%CURR_DIR%\..\..\..\..\..\..\..\jvm\jvm\bin\java"
) ELSE (
    SET JAVA_EXE="%JRE_HOME%\bin\java"
)


SET TENANT_DIR=%CURR_DIR%..\..\..\..\
SET IS_DIR=%CURR_DIR%..\..\..\..\..\..\
SET IS_INSTANCE_DIR=%CURR_DIR%..\..\..\..\

SET CLASSPATH=;%CURR_DIR%..\..\code\jars\*;%CURR_DIR%..\..\code\jars\static\*

SET CLASSPATH=%CURR_DIR%..\..\..\..\..\..\..\common\lib\ext\jackson-databind.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\..\..\..\..\..\..\common\lib\ext\jackson-annotations.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\..\..\..\..\..\..\common\lib\ext\jackson-core.jar;%CLASSPATH%
SET CLASSPATH=%CURR_DIR%..\..\..\..\..\..\..\common\lib\ext\jackson-dataformat-yaml.jar;%CLASSPATH%
set CLASSPATH=%IS_DIR%lib\wm-isserver.jar;%CLASSPATH%
set CLASSPATH=%IS_DIR%..\common\lib\*;%CLASSPATH%

set CLASSPATH=%CURR_DIR%..\lib\*;%CLASSPATH%
set CLASSPATH=%IS_DIR%..\common\runtime\bundles\tes\eclipse\plugins\net.sf.ehcache*.jar;%CLASSPATH%
set CLASSPATH=%IS_DIR%..\common\runtime\bundles\platform\eclipse\plugins\*;%CLASSPATH%
set CLASSPATH=%IS_DIR%..\common\runtime\bundles\esapi\eclipse\plugins\*;%CLASSPATH%
set CLASSPATH=%IS_INSTANCE_DIR%lib\jars\*;%CLASSPATH%
set CLASSPATH=%CURR_DIR%..\..\config\resources\cloud\;%CLASSPATH%


%JAVA_EXE% -Dinstance.dir=%TENANT_DIR%  -Dcom.softwareag.install.root=%CURR_DIR%\..\..\..\..\..\..\..\ com.softwareag.apigateway.utility.initializer.APIGatewayUtilityStartup  %*
set exitcode_test=%errorlevel%
GOTO :EOF






:usage
echo  Usage: apigatewayUtil.bat [COMMANDS AND OPTIONS]
echo  COMMANDS LIST::
echo  -----------------------------------------------------------------------------
echo  configure manageRepo        Command to configure repository
echo     options
echo        -tenant               Specify tenant name (optional)
echo        -repoName             Specify repository name (optional)
echo        -analyticsDS          (optional) Specify as true to configure a repository for the Analytics Datastore
echo        -file                 File path to read repository details (optional)
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  delete  manageRepo          Command to delete repository
echo     options
echo        -tenant               Specify tenant name (optional)
echo        -repoName             Specify repository name (optional)
echo        -analyticsDS          (optional) Specify as true to configure a repository for the Analytics Datastore
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  list manageRepo             Command to list all repositories
echo        -analyticsDS          (optional) Specify as true to list repositories for the Analytics Datastore
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  create backup               Command to create backup
echo     options
echo        -tenant               Specify tenant name (optional)
echo        -repoName             Specify repository name (optional)
echo        -name                 Specify backup file name  (optional)
echo        -analyticsDS          (optional) Specify as true to create a backup of the Analytics Datastore
echo        -include              (optional) Specify one of the following backup type in case of partial backup:
echo                                 1.'analytics' to backup runtime data
echo                                 2.'assets' to backup assets.
echo                                 3.'license' to backup license metrics
echo                                 4.'audit' to backup audit logs
echo                                 5.'log' to backup log data
echo                                 Example partial backup: -include assets or -include assets,analytics
echo        -indices              Specify index name to backup particular index
echo                              Allows multiple value by comma separated or using wildcard (*)
echo                              Example: -indices gateway_default_apis,gateway_default_policy or -indices gateway*
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  list backup                 Command to list backup files in repository
echo     options
echo        -tenant               Specify tenant name  (optional)
echo        -repoName             Specify repository name (optional)
echo        -analyticsDS          (optional) Specify as true to list a backup of the Analytics Datastore
echo        -status               Specify to filter results based on status. Applicable values are SUCCESS, FAILED and IN_PROGRESS. Allows multiple value by comma separated
echo        -verbose              Specify true to view detailed output
echo        -format               Specify json/text to view verbose output in json or text format. Example: -verbose true -format json
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  delete backup               Command to delete the backup file
echo     options
echo        -tenant               Specify tenant name  (optional)
echo        -repoName             Specify repository name (optional)
echo        -analyticsDS          (optional) Specify as true to delete a backup of the Analytics Datastore
echo        -name                 Specify backup file name. Either -name or -olderThan should be provided
echo        -olderThan            Specify to delete backups older than given number of days. Possible values: d(days)
echo                              Example: delete backup -olderThan 30d
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  restore backup          Command to restore the backup file
echo     options
echo        -tenant                (optional) Specify tenant name
echo        -repoName              (optional) Specify repository name
echo        -analyticsDS           (optional) Specify as true to restore a backup of the Analytics Datastore
echo        -name                  (required) Specify backup file name
echo        -sync                  (optional) Select true to make process synchronous, else select false to make it asynchronous. The default value is false.
echo        -srcTenant             (optional) If specified, this parameter indicates that the tenant name in the backup is different from the tenant name onto which we are going to restore.
echo                               This will take the data from the backup with the tenant name given by '-srcTenant' and restore the data with the tenant name provided by '-tenant'.
echo                               If not provided, then it is assumed that the name of the tenant in the backup file and the name of the tenant in elasticsearch are the same.
echo        -include               (optional) Specify one or more of the following (comma-separated) in order to restore only partial data from the backup:
echo                                 1.'analytics' to restore runtime data
echo                                 2.'assets' to restore assets
echo                                 3.'license' to restore license metrics
echo                                 4.'audit' to restore audit logs
echo                                 5.'log' to restore log data
echo                               Example partial backup: -include assets or -include assets,analytics
echo        -aggregate             (optional) Specify as true to aggregate the existing and restored data, instead of entirely replacing the existing data.
echo                               The default value is false. Applicable only to license, log, audit and analytics types of data.
echo        -restoreClusterState   (optional) Specify as true to restore the global state settings such as templates and cluster state along with the data. The default value is false.
echo                               Do not use this parameter for normal restore operations. Use only when restoring backup from a different elasticsearch or when -srcTenant is specified.
echo        -logFileLocation       (optional) Specify the file system location where logs needs to be saved. File name must end with '.log' extension
echo                                Default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel              (optional) Specify log level. Default level is info
echo.
echo  status backup               Command to get the status of the backup file
echo     options
echo        -tenant               Specify tenant name (optional)
echo        -repoName             Specify repository name (optional)
echo        -analyticsDS          (optional) Specify as true to get the status of a backup of the Analytics Datastore
echo        -name                 Specify backup file name
echo        -verbose              Specify true to view detailed output
echo        -format               Specify json/text to view verbose output in json or text format.
echo                              Example: -verbose true -format json
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  status restore              Command to get the status of the restore
echo     options
echo        -tenant               (optional) Specify tenant name
echo        -repoName             (optional) Specify repository name
echo        -analyticsDS          (optional) Specify as true to get the status of the restore of the Analytics Datastore
echo        -name                 (required) Specify restore file name
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  configure fs_path           -path c://sample//APIGATEWAY  Command to update Elasticsearch File system path
echo        -path                 File system location
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  perform open_indices        Command to open all indices of API Gateway in Elasticsearch
echo        -analyticsDS          (optional) Specify as true to perform open indices in the Analytics Datastore 
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  rollover index              Command to rollover
echo     options
echo        -type      specify the name of the alias to rollover. Only Events, logs and trace type alias supported.
echo                              Options:
echo                              1. performancemetrics       2. policyviolationevents   3. monitorevents     4. errorevents
echo                              5. threatprotectionevents   6. transactionalevents     7. lifecycleevents   8. auditlogs
echo                              9. log                      10. serverlogtrace         11. mediatortrace    12. requestresponsetrace
echo                              Example: rollover index -type monitorevents
echo        -analyticsDS          (optional) Specify as true to rollover indices in the Analytics Datastore 
echo        -tenant               Specify tenant name (optional)
echo        -targetIndexSuffix    specify the target index suffix (optional)
echo        -maxAge               specify the condition of max age (optional)
echo        -maxDocs              specify the condition of max documents (optional)
echo        -maxSize              specify the condition of max size (optional)
echo        -maxPrimaryShardSize  specify the condition of max primary shard size (optional)
echo        -dryRun               select true to execute dry run (optional)
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
echo  export platformConfiguration        Command to export platform configuration
echo        -url                  specify the url
echo        -username             specify the username
echo        -password             specify the password (optional). If not provided, password is prompted via console.
echo        -filePath             specify the file system directory
echo        -logFileLocation      specify the file system location where logs needs to be saved. File name must end with '.log' extension (optional)
echo                              default location: "<install_dir>/IntegrationServer/instances/default/packages/WmAPIGateway/cli/logs/APIGWUtility.log"
echo        -logLevel             specify log level (optional). Default level is info
echo.
goto :EOF

:AddToPath
SET CLASSPATH=%1;%CLASSPATH%
goto :EOF
