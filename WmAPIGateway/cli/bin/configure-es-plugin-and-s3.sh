#!/bin/bash

mkdir -p logs
exec > >(tee -a -i logs/configure-es-plugin-and-s3.log)
exec 2>&1

echo ""
echo "$(date -Iseconds) : $0 script has been invoked with arguments $* from location $PWD "
echo "All the log file data available at ${PWD}/logs/configure-es-plugin-and-s3.log"

# Steps..
# ensure Elasticsearch is running
# configure plugin
# restart
# apigatewayUtil.sh manage repo
# AWS S3 setup..

if [[ $environment == "CLOUD" ]]; then
    echo -e "Welcome to set up Configuration of Elasticsearch repository.."
else
    echo -e "Welcome to set up the cloud-aws plugin, AWS CLI, configuration of Elasticsearch repository.."
fi

echo -e "Ensure API Gateway is up and running and couple of restart of application will happen as part of the configuration process."

# optional for on-premise and mandatory for Cloud - defaulted to "on-premise", for cloud - invoke as "cloud"
environment=

# mandatory input if s3ConfigurationFile is not supplied
backupDestinationDirectory=

# mandatory input if backupDestinationDirectory is not supplied and preference is s3ConfigurationFile if both supplied.
s3ConfigurationFile=

# mandatory - not for On-premise, but for cloud scenario
tenantName=

# Not an user input
backupToLocationType=

CLI_BIN_SCRIPTS_DIR="$PWD"
error_count=0

echo -e "List of input arguments received $* "

while [ "$1" != "" ]; do
    case "$1" in

    -s3 | --s3-configuration-file | -s3ConfigurationFile)
        echo "matched s3 configuration file"
        shift
        if [[ -e "$1" ]]; then
            echo "valid S3 file name $1"
            s3ConfigurationFile=$(readlink -f "$1")
            bucket="$(grep bucket "${s3ConfigurationFile}" | cut -f2 -d=)"

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

    -h | --help | -help)
        echo ""
        echo -e "Following are the valid options to execute this $0 script"
        echo ""
        echo "    -backupDestinationDirectory   Backup destination directory - full valid local path - use this option only when backup in local instance itself"
        echo ""
        echo "    -s3ConfigurationFile          AWS S3 location as backup destination - full valid path upto file name - use this option only when application to be backed up to S3 location"
        echo ""
        echo "    -backupDestinationDirectory (or) -s3ConfigurationFile"
        echo "                                  Either one of this option is supported at a time."
        echo ""
        echo "    -tenantName                   Enter the tenant name, if ignored 'default' is assumed"
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

if [[ ! -z "$s3ConfigurationFile" ]]; then
    backupToLocationType="S3"
    if [[ -z "$backupDestinationDirectory" ]]; then
        backupDestinationDirectory="$CLI_BIN_SCRIPTS_DIR"
    fi
elif [[ $environment == "CLOUD" && (-z "$s3ConfigurationFile") ]]; then
    echo -e "-s3ConfigurationFile is mandatory in CLOUD scenario."
    ((error_count++))
elif [[ ! -z "$backupDestinationDirectory" ]]; then
    backupToLocationType="NFS"
else
    echo "Please invoke the $0 script with -s3ConfigurationFile OR -backupDestinationDirectory option"
    ((error_count++))
fi

if [[ -z $tenantName ]]; then
    echo -e 'setting tenant name as "default"'
    tenantName="default"
fi

echo -e "value of s3ConfigurationFile is $s3ConfigurationFile"
echo -e "value of backupDestinationDirectory is $backupDestinationDirectory"
echo -e "tenant name is $tenantName"
echo -e "value of backupToLocationType is $backupToLocationType"
echo -e "value of bucket is $bucket"

if ((error_count > 0)); then
    echo "Exiting the script due to input error."
    exit 02
fi

# $0 script assumed to be in the cli/bin folder..
intermediatePath="$(dirname "$(dirname "$(dirname "$(dirname "${CLI_BIN_SCRIPTS_DIR}")")")")"
tenantInstanceName="$(basename "${intermediatePath}")"
relativePath="$(dirname "$(dirname "$(dirname "${intermediatePath}")")")"

restartEDS() {
    bash "${relativePath}"/InternalDataStore/bin/restart.sh
    echo "About to sleep for 40 seconds"
    sleep 40s
}

restartAPIGw() {
    bash "${relativePath}"/profiles/IS_"$tenantInstanceName"/bin/restart.sh
    # echo "About to sleep for 120 seconds"
    # sleep 120s
}

changeDirectory() {
    location="$1"
    if ! cd "${location}"; then
        echo "Unable to navigate to ${location} and hence exiting $0 script."
        exit 1
    else
        echo -e "changing directory to ${location}"
    fi
}

# configure Elasticsearch repository..

if [[ "$backupToLocationType" == "S3" ]]; then

    # get confirmation from user to proceed..
    if [[ $environment == "ON-PREMISE" ]]; then

        read -r -p "Continue configuring (y|n)?" answer

        case ${answer:0:1} in
        y | Y)
            echo -e "Thank you for confirming to proceed."
            ;;
        *)
            echo -e "Ok, discontinuing the configuration setup now.."
            exit 01
            ;;
        esac
    fi

    # Change directory to API Gateway installed location.
    changeDirectory ${relativePath}

    # Elasticsearch - install cloud-aws plugin..
    # For CLOUD, cloud-aws plugin gets installed before taking AMI process..
    if [[ $environment == "ON-PREMISE" ]]; then

        echo -e "About to configure cloud-aws plugin in Elasticsearch"

        pluginPath="InternalDataStore/bin/"

        changeDirectory ${pluginPath}

        yes Y y | sh plugin.sh install cloud-aws

        exit_code_of_plugin_exec=$?
        echo "Execution value of cloud-aws plugin installation is $exit_code_of_plugin_exec"

        if (($exit_code_of_plugin_exec > 0)); then
            echo "cloud-aws plugin installation is not successful and hence exiting the script execution"
            echo "Please execute the following command: sh plugin.sh install cloud-aws"
            exit 03
        fi

        restartEDS
        echo -e "API Gateway InternalDataStore has been restarted for cloud-aws plugin to be effective"
    fi

    echo -e "About to configure manageRepo for S3"

    changeDirectory ${CLI_BIN_SCRIPTS_DIR}

    # execute configure s3 command for Elasticsearch.
    bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh configure manageRepo -tenant "${tenantName}" -file "${s3ConfigurationFile}" -debug true

    echo ""
    echo "List of available repositories for this Elasticsearch."
    bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh list manageRepo

    if [[ $environment == "ON-PREMISE" ]]; then

        echo -e "About to setup AWS S3 communication via AWS CLI installation."

        bash "${CLI_BIN_SCRIPTS_DIR}"/apigw-setup-aws-s3.sh "${s3ConfigurationFile}"
    fi

elif [[ "$backupToLocationType" == "NFS" ]]; then

    changeDirectory ${CLI_BIN_SCRIPTS_DIR}

    echo -e "About to configure fs_path for NFS"
    bash "${CLI_BIN_SCRIPTS_DIR}"/apigatewayUtil.sh configure fs_path -path "${backupDestinationDirectory}" -tenant "${tenantName}" -debug true

else
    echo -e "Unsupported backup type.."
fi

if [[ $environment == "CLOUD" ]]; then
    echo -e "Configuration of Elasticsearch repository is completed."
else
    echo -e "Configuration of cloud-aws plugin, AWS CLI and configuration of Elasticsearch repository are completed."
    echo -e "NOTE: Restart of API Gateway is in progress for configuration to be effective.."
	restartAPIGw
fi


