#!/bin/bash
echo "Deprecation Warning: This script has been deprecated. It would be removed from the future releases. Please use apigatewayUtil."

DATE=$(date +%Y-%m-%d-%H%M)

mkdir -p logs
LOG_FILE=logs/backup-tenant-"$DATE".log

exec > >(tee -a -i "$LOG_FILE")
exec 2>&1

echo
date
echo

echo "$(date -Iseconds) : $0 script has been invoked with arguments $* from location $PWD "
echo "All the log file data available at ${PWD}/logs/backup-tenant.log"

echo -e "Welcome to the API Gateway Backup Service.."

CLOUD_BIN_SCRIPTS_DIR="$PWD"
ROOT_SCRIPTS_DIR=$(dirname $(dirname "$PWD"))
CLI_BIN_SCRIPTS_DIR="$ROOT_SCRIPTS_DIR"/cli/bin

echo "Value of CLOUD_BIN_SCRIPTS_DIR is $CLOUD_BIN_SCRIPTS_DIR"
echo "Value of CLI_BIN_SCRIPTS_DIR is $CLI_BIN_SCRIPTS_DIR"

#java name
UTIL_JARS="$(dirname "$(dirname "$PWD")")"
TENANT_DIR="$(dirname "$(dirname "$(dirname "$(dirname "$PWD")")")")"
JAR_DIR="${TENANT_DIR}/packages/WmAPIGateway/code/jars"

CLI="$(dirname $PWD)"
JAVA_DIR="$(dirname "$(dirname "$(dirname $TENANT_DIR)")")/jvm/jvm"
IS_DIR="$(dirname "$(dirname "$(dirname $TENANT_DIR)")")"

for file in $(ls $JAR_DIR/*.jar); do
    CLASSPATH=$file:$CLASSPATH
done
for file in $(ls $CLI/lib/*.jar); do
    CLASSPATH=$file:$CLASSPATH
done
for file in $(ls $JAR_DIR/static/jackson*.jar); do
    CLASSPATH=$file:$CLASSPATH
done

for file in $(ls $UTIL_JARS/cloud/lib/*.jar); do
    CLASSPATH=$file:$CLASSPATH
done

#CLASSPATH=$CLASSPATH:../lib/aws-java-sdk-s3-1.11.204.jar

export CLASSPATH

JAVA_EXE="$JAVA_DIR/bin/java"

# mandatory input
backupFileName=

# mandatory input if s3ConfigurationFile is not supplied
backupDestinationDirectory=

# mandatory input if backupDestinationDirectory is not supplied and preference is s3ConfigurationFile if both supplied.
s3ConfigurationFile=

# mandatory - not for On-premise, but for cloud scenario
tenantName=

# optional - To backup to a different repository than the one with the tenant name
repositoryName=

# optional - decide which assets are to be backup - only analytics, only assets or everything
backupDataFilter=

# optional if following the convention of maintaining the list of packages and configs to be backed up in file tenant-backup-template.txt at ./IntegrationServer/instances/default/packages/WmAPIGateway/cli/bin/conf/
backupTemplate=

# comma separated list of packages
packages=

# Not an user input
backupToLocationType=

error_count=0

# optional for on-premise and mandatory for Cloud - defaulted to "on-premise", for cloud - invoke as "cloud"
environment=

configBackupPath=
bucket=

while [ "$1" != "" ]; do

    case "$1" in

    -f | --backup-file-name | -backupFileName)
        echo "matched backup file name"
        shift
        if [[ ! -z "$1" ]]; then
            case "$1" in
            *\ *)
                echo "Invalid backup file name: '$1'. It contains space"
                ((error_count++))
                ;;
            *)
                echo "valid backup file name"
                backupFileName="$1"
                ;;
            esac
        else
            echo "invalid backup file name: $1"
            ((error_count++))
        fi
        ;;

    -s3 | --s3-configuration-file | -s3ConfigurationFile)

        echo "matched s3 configuration file"
        shift
        if [[ -e "$1" ]]; then
            echo "valid S3 file name $1"
            s3ConfigurationFile=$(readlink -f "$1")
            esBasePath="$(grep base_path "${s3ConfigurationFile}" | cut -f2 -d=)"
            configBackupPath="$(grep apigw_config_backup_path "${s3ConfigurationFile}" | cut -f2 -d=)"
            packagesS3BackupPath="$(grep apigw_packages_backup_path "${s3ConfigurationFile}" | cut -f2 -d=)"
            bucket="$(grep bucket "${s3ConfigurationFile}" | cut -f2 -d=)"

            if [[ -z "$esBasePath" ]]; then
                echo -e "invalid base_path ${esBasePath} mentioned at ${s3ConfigurationFile}"
                ((error_count++))
            else
                echo -e "valid base_path ${esBasePath} mentioned at ${s3ConfigurationFile}"
            fi

            if [[ -z "$configBackupPath" ]]; then
                echo -e "invalid apigw_config_backup_path ${configBackupPath} mentioned at ${s3ConfigurationFile}"
            else
                echo -e "valid apigw_config_backup_path ${configBackupPath} mentioned at ${s3ConfigurationFile}"
            fi

            if [[ -z "$packagesS3BackupPath" ]]; then
                echo -e "invalid apigw_packages_backup_path ${packagesS3BackupPath} mentioned at ${s3ConfigurationFile}"
            else
                echo -e "valid apigw_packages_backup_path ${packagesS3BackupPath} mentioned at ${s3ConfigurationFile}"
            fi

            if [[ -z "$bucket" ]]; then
                echo -e "invalid bucket ${bucket} mentioned at ${s3ConfigurationFile}"
                ((error_count++))
            else
                echo -e "valid bucket ${bucket} mentioned at ${s3ConfigurationFile}"
            fi
        else
            echo "invalid s3 configuration file name: $1"
            ((error_count++))
        fi
        ;;

    --backup-config-template | -backupConfigTemplate)
        echo "matched backup template"
        shift
        if [[ -e "$1" ]]; then
            echo "valid template file"
            backupTemplate=$(readlink -f "$1")
        else
            echo "invalid backup template file"
            ((error_count++))
        fi
        ;;

    -d | --backup-destination-directory | -backupDestinationDirectory)
        echo "matched backup destination directory.."
        shift
        if [[ -d "$1" ]]; then
            echo "valid directory.."
            backupDestinationDirectory=$(readlink -f "$1")
        else
            echo "invalid directory name: $1"
            ((error_count++))
        fi
        ;;

    -t | --tenant-name | -tenantName)
        echo "matched tenant name"
        shift
        if [[ ! -z "$1" ]]; then
            case "$1" in
            *\ *)
                echo "invalid tenant name: '$1'. It contains space."
                ((error_count++))
                ;;
            *)
                echo "valid tenant name"
                tenantName="$1"
                ;;
            esac
        else
            echo "invalid tenant name: $1"
            ((error_count++))
        fi
        ;;

    -r | --repository-name | -repositoryName)
        echo "matched repository name"
        shift
        if [[ ! -z "$1" ]]; then
            case "$1" in
            *\ *)
                echo "invalid repository name: '$1'. It contains space."
                ((error_count++))
                ;;
            *)
                echo "valid repository name"
                repositoryName="$1"
                ;;
            esac
        else
            echo "repository name is not provided and hence will be assumed to be the same as tenant name."
            repositoryName="$tenantName"
        fi
        ;;

    --backup-data-filter | -backupDataFilter)
        echo "matched backup data filter"
        shift
        if [[ ! -z "$1" ]]; then
            case "$1" in
            assets | analytics)
                echo "valid backup data filter"
                backupDataFilter="$1"
                ;;
            all)
                echo "valid backup data filter"
              ;;
            *)
                echo "invalid backup data filter name name: '$1'. Allowed values: analytics, assets, all"
                ((error_count++))
                ;;
            esac
        else
            echo "backup data filter is not provided and hence will take a backup of all available data"
        fi
        ;;

    -e | --environment | -environment)
        echo "matched environment"
        shift
        if [[ ! -z "$1" && ("$1" == "ON-PREMISE" || "$1" == "CLOUD") ]]; then
            echo "valid environment"
            environment="$1"
        else
            echo "invalid environment name: '$1'. It can be either of 'CLOUD' or 'ON-PREMISE'"
            ((error_count++))
        fi
        ;;

    --packages-template | -packagesTemplate)
        echo "matched packages template"
        shift
        if [[ -e "$1" ]]; then
            echo "valid packages template file"
            packagesTemplate=$(readlink -f "$1")
        else
            echo "invalid packages template file"
            ((error_count++))
        fi
        ;;

    # -p | --packages | -packages)
    #     echo "matched packages"
    #     shift
    #
    #     if [[ -z "$1" ]]; then
    #         ((error_count++))
    #         echo "-packages option should be called with list of package names with comma separated"
    #     else
    #         packages="$1"
    #     fi
    #     ;;

    -h | --help | -help)

        echo -e "Following are the valid options to execute this $0 script"
        echo ""
        echo "    -backupFileName               File name on which to backup - without any extension"
        echo ""
        echo "    -backupDestinationDirectory   Backup destination directory - full valid local path - use this option only when backup in local instance itself"
        echo ""
        echo "    -s3ConfigurationFile          AWS S3 location as backup destination - full valid path upto file name - use this option only when application to be backed up to S3 location"
        echo ""
        echo "    -backupDestinationDirectory (or) -s3ConfigurationFile"
        echo "                                  Either one of this option is supported and manadatory at a time."
        echo ""
        echo "    -tenantName                   Enter the tenant name, if ignored 'default' is assumed"
        echo ""
        echo "    -repositoryName               Enter the repository name, if ignored the tenant name is assumed as the repository name"
        echo ""
        echo "    -backupDataFilter             The data to filter and backup. Possible values: assets, analytics, all"
        echo ""
        echo "    -backupConfigTemplate         list of configuration files to be backed up can be mentioned in a file and the path to the file is being referred here."
        echo "                                  example: ${CLOUD_BIN_SCRIPTS_DIR}/conf/tenant-backup-template.txt"
        echo ""
        echo "    -packagesTemplate             list of custom packages to be backed up can be mentioned in a file and the path to the file is being referred here."
        echo "                                  example: ${CLOUD_BIN_SCRIPTS_DIR}/conf/tenant-backup-packages.txt"
        echo ""
        exit
        ;;

    *)
        echo "Invalid option $1"
        echo -e "Please refer help for script $0 -help"
        exit
        ;;

    esac

    shift

done

# input validations..

if [[ -z $environment ]]; then
    echo -e 'setting environment as "ON-PREMISE"'
    environment="ON-PREMISE"
fi

if [[ -z "$packagesTemplate" ]]; then
    packagesTemplate=$(readlink -f "${CLOUD_BIN_SCRIPTS_DIR}/conf/tenant-backup-packages.txt")
    echo -e "Assuming the -packagesTemplate to be ${packagesTemplate}. Hope list of packages to be backed up are mentioned in this file"

    if [[ ! -e "${packagesTemplate}" ]]; then
        echo -e "Invalid ${packagesTemplate} file. Please invoke $0 script with valid -packagesTemplate option"
        ((error_count++))

    fi
fi

if [[ -z "$backupTemplate" ]]; then
    backupTemplate=$(readlink -f "${CLOUD_BIN_SCRIPTS_DIR}/conf/tenant-backup-template.txt")
    echo -e "Assuming the -backupTemplate to be $backupTemplate"

    if [[ ! -e "${backupTemplate}" ]]; then
        echo -e "Invalid ${backupTemplate} file. Please invoke $0 script with valid -backupTemplate option"
        ((error_count++))
    fi
fi

if [[ ! -z "$s3ConfigurationFile" ]]; then
    backupToLocationType="S3"
    if [[ -z "$backupDestinationDirectory" ]]; then
        backupDestinationDirectory="${CLOUD_BIN_SCRIPTS_DIR}"
    fi
    if [[ $environment == "ON-PREMISE" ]]; then
        if [[ -z "$packagesS3BackupPath" || -z "$configBackupPath" ]]; then
            ((error_count++))
        fi
    fi
elif [[ -z "$s3ConfigurationFile" && ($environment == "CLOUD") ]]; then
    echo -e "-s3ConfigurationFile option is manadatory in case of CLOUD scenario."
    ((error_count++))
elif [[ ! -z "$backupDestinationDirectory" ]]; then
    backupToLocationType="NFS"
else
    echo "Please invoke the $0 script with -s3ConfigurationFile OR -backupDestinationDirectory option"
    ((error_count++))
fi

if [[ -z $tenantName ]]; then
    echo -e 'Assuming the -tenantName as "default"'
    tenantName="default"
fi

if [[ -z $repositoryName ]]; then
    echo -e "Assuming the -repositoryName as '$tenantName'"
    repositoryName="$tenantName"
fi

if [[ -z $backupDataFilter ]]; then
    echo -e "The data filter to backup has not been specified. Hence the entire data will be backed up."
fi

if [[ -z "${backupFileName}" ]]; then
    echo -e "-backupFileName option is mandatory."
    ((error_count++))
fi

echo -e "Total error count is $error_count"
echo -e "value of backupFileName is $backupFileName"
echo -e "value of backupTemplate is $backupTemplate"
echo -e "value of packagesTemplate is $packagesTemplate"
echo -e "tenant name is $tenantName"
echo -e "repository name is $repositoryName"
echo -e "backupDataFilter is $backupDataFilter"
echo -e "value of backupToLocationType is $backupToLocationType"
echo -e "value of s3ConfigurationFile is $s3ConfigurationFile"
echo -e "value of bucket is $bucket"
echo -e "value of esBasePath is $esBasePath"
echo -e "value of configBackupPath is $configBackupPath"
echo -e "value of packagesS3BackupPath is $packagesS3BackupPath"
echo -e "value of backupDestinationDirectory is $backupDestinationDirectory"

if ((error_count > 0)); then
    echo -e "Please refer help for script $0 -help"
    echo "Exiting the script due to input error."
    exit 1
fi

# Do an Elasticsearch backup..

echo -e "Initiating Elasticsearch backup process in synchronous mode.."
echo -e "It's a time consuming process depending upon the data volume in your EventDataStore. (so, it's not hanging..). Executing in synchronous mode to fail fast to avoid incomplete backups."

if ! cd "${CLI_BIN_SCRIPTS_DIR}"; then
    echo "Unable to navigate to ${CLI_BIN_SCRIPTS_DIR} and hence existing from backup process."
    exit 1
else
    echo "changing to directory ${CLI_BIN_SCRIPTS_DIR}"
fi

# BACKUP_EXIT_CODE=$(bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh create backup -tenant "${tenantName}" -name "${backupFileName}" -debug true -sync true)

if [[ -z $backupDataFilter ]]; then
    bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh create backup -tenant "${tenantName}" -repoName "${repositoryName}" -name "${backupFileName}" -debug true -sync true
else
    bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh create backup -tenant "${tenantName}" -repoName "${repositoryName}" -name "${backupFileName}" -include "${backupDataFilter}" -debug true -sync true
fi

BACKUP_EXIT_CODE=$?
echo "BACKUP_EXIT_CODE of Backup process is $BACKUP_EXIT_CODE"

if (($BACKUP_EXIT_CODE > 0)); then
    echo
    echo "Backup process for customer ${tenantName} FAILED.. Please look into it.."
    date
    exit 1
else
    echo
    echo -e "Elastic search is backed up to the configured repository location - SUCCESSFULLY.."
fi

# Deletion of Elasticsearch older backups..
# echo ""
# echo -e "Elastic search clean up of old backup files.."
# daysToCleanUp=1
# removeBackupFile=
#
# if [[ ! -z "$removeBackupFile" ]]; then
#     bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh delete backup -name "${removeBackupFile}" -debug true -sync true
#     echo ""
#     echo -e "Removal of older backup file from Elastic search backup is done for file name: ${removeBackupFile}"
# else
#     echo ""
#     echo -e "No need to remove old Elasticsearch backup at this point as the days to clean up ${daysToCleanUp} is not greater than list of backups available"
# fi

echo
echo "List of available Elasticsearch backups.."
LIST_OF_BACKUPS=$(bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh list backup -tenant "${tenantName}" -repoName "${repositoryName}" -debug true)
LIST_OF_BACKUPS_EXIT_CODE=$?
# bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh list backup -tenant "${tenantName}" -debug true
# LIST_OF_BACKUPS=$?

if (($LIST_OF_BACKUPS_EXIT_CODE > 0)); then
    echo
    echo "Unable to list the backups taken so far - to validate current backup for customer ${tenantName} is success of failure and hence exiting with non-zero code.."
    date
    exit 1
else
    echo
    echo "$LIST_OF_BACKUPS"
fi

if [[ "$LIST_OF_BACKUPS" == *"${backupFileName}"* ]]; then
    echo
    echo "Backup triggered now is really SUCCESSFUL as able to find the backup file name ${backupFileName} in the backed up list for the customer ${tenantName}.."
    echo
else
    echo
    echo "Something gone wrong, backup completed successfully, but unable to find the backed up file name ${backupFileName} in the list of available backups for the customer ${tenantName}.. Please look into it.."
    date
    exit 1
fi

# Do an API Gateway packages backup..
# if [[ ! -z $packagesS3BackupPath && $environment != "CLOUD" ]]; then
if [[ ! -z $packagesS3BackupPath && $environment != "CLOUD" ]]; then
    echo "Invocation to apigw-backup-packages.sh script to do packages backup from $0 script.."
    bash "${CLI_BIN_SCRIPTS_DIR}"/apigw-backup-packages.sh -packagesTemplate "$packagesTemplate" -s3ConfigurationFile "$s3ConfigurationFile" -environment "$environment"
fi
echo

# Do an API Gateway configs backup..
if [[ ! -z $configBackupPath && $environment != "CLOUD" ]]; then
    echo -e "Initiating API Gateway configs backup.."
    # bash "${CLI_BIN_SCRIPTS_DIR}"/apigw-backup-configs.sh -s3ConfigurationFile "$s3ConfigurationFile" -environment "$environment"

    # creating a backup file folder..
    DESTINATION=$(readlink -f "${backupDestinationDirectory}/${backupFileName}")
    mkdir -p "${DESTINATION}"
    echo -e "created new folder ${DESTINATION}"

    # $0 script assumed to be in the cli/bin folder..
    intermediatePath=$(dirname "$(dirname "$(dirname "$(dirname "${CLI_BIN_SCRIPTS_DIR}")")")")
    tenantInstanceName=$(basename "${intermediatePath}")
    relativePath=$(dirname "$(dirname "$(dirname "${intermediatePath}")")")

    # Change directory to API Gateway installed location.
    if ! cd "${relativePath}"; then
        echo -e "changing directory to ${relativePath} has failed and hence existing without proceeding further to avoid any possible damages to the environment."
    fi

    # iterate through input file and copy the files to destination folder

    while read -r line; do
        if [[ -z "$line" ]]; then
            echo -e "Empty line in the input file.."
        else
            echo "$line"
            temp=${line#*.}
            echo -e "temp-line: $temp"

            if [[ -d "$line" ]]; then
                echo " - is a valid directory.."
                echo -e "value of temp now $temp"

                tempDestination=$DESTINATION$temp
                mkdir -p "${tempDestination}"

                if [[ -d $tempDestination ]]; then
                    echo "New folder created successfully.. $tempDestination"
                fi

                \cp -r "${line}"/* "${tempDestination}"

                echo -e "copied directory recursively $line.."

            elif [[ -e "$line" ]]; then
                echo " - is a valid file.."

                temp=$(dirname "${temp}")
                echo -e "basename is $temp"

                tempDestination=$DESTINATION$temp

                mkdir -p "${tempDestination}"

                if [[ -d $tempDestination ]]; then
                    echo "New folder created successfully.. $tempDestination"
                fi

                \cp "${line}" "${tempDestination}"

                echo -e "copied file $line.."

            else
                echo " - is not valid file / directory.."
            fi
        fi
    done <"$backupTemplate"

    # creates metadata file and populates the instance name key / value in it..
    echo "apigateway-instance-name=${tenantInstanceName}" >"$(readlink -f "${backupDestinationDirectory}/${backupFileName}"/metadata.txt)"

    # compress the backup files..
    if ! cd "${backupDestinationDirectory}"; then
        echo -e "changing directory to ${backupDestinationDirectory} has failed. Hence exiting without proceeding further to avoid any damages to the instance."
        exit 1
    fi

    backupFileNameZip="${backupFileName}.zip"
    zip -r "$backupFileNameZip" "$backupFileName" >/dev/null

    echo -e "Created a compressed backup file at ${backupDestinationDirectory}/${backupFileNameZip}"
    # ls -l

    echo -e "completed.."

    backupFile="${backupDestinationDirectory}/${backupFileNameZip}"
    backupFileFolder="${backupDestinationDirectory}/${backupFileName}"

    echo "backupFile value is $backupFile"

    echo -e "about to remove ${backupFileFolder}"

    if [[ -d "${backupFileFolder}" ]]; then
        rm -rf "${backupFileFolder}"
    fi

    echo -e "done with removing ${backupFileFolder}"

    # Do S3 steps..

    if [[ "$backupToLocationType" == "S3" ]]; then
        echo "about to copy to S3"

        if ! cd "${CLI_BIN_SCRIPTS_DIR}"; then
            echo "Unable to navigate to ${CLI_BIN_SCRIPTS_DIR} and hence not able to upload the backup to S3 location. Exiting now."
            exit 1
        else
            echo "changing to directory ${CLI_BIN_SCRIPTS_DIR}"
        fi

        if [[ $environment == "ON-PREMISE" ]]; then
            export PATH=$PATH:~/bin
        fi

        #aws s3 cp "${backupFileNameZip}" s3://"${bucket}${configBackupPath}"

        $JAVA_EXE -cp $CLASSPATH -Doperation=backup -Ds3ConfigurationFile="$s3ConfigurationFile" -Dsource="$backupFileNameZip" -Dtype=config -Ddebug=true com/softwareag/apigateway/utility/cloud/storage/controller/ApplicationController $*
        # aws s3 cp "${backupFile}" s3://"${bucket}${configBackupPath}"
        # bash "${CLI_BIN_SCRIPTS_DIR}"/aws-s3-cmd-exec.sh "$backupFile" "s3://$bucket$configBackupPath"
        exit_code_of_aws_cp=$?

        echo "Value of exit code of AWS S3 copy is ${exit_code_of_aws_cp}"

        if ((exit_code_of_aws_cp == 0)); then
            echo "Exit code of copying backup file to S3 location says SUCCESS and hence about to clean up the local copy of the $backupFile"
            if [[ -e "${backupFile}" ]]; then
                rm -f "${backupFile}"
                echo -e "done with clean up.."
            fi
        else
            echo "Backup file is available at ${backupFile}"
            echo "Please upload that to AWS S3 by executing the command as ~/bin/aws s3 cp $backupFile s3://${bucket}${configBackupPath}"
            echo "After successful upload, please clean up the ${backupFile} file if not needed"
        fi

    elif [[ "$backupToLocationType" == "NFS" ]]; then
        echo -e "Done with backup of API Gateway, You may please find the backup file $backupFile"

    else
        echo -e "Backup failure, please contact Administrator with log files / screen shots and with steps followed."
    fi
fi

echo -e "Thank you for using API Gateway Backup Service.."
echo ""
