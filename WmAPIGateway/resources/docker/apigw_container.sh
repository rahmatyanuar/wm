#!/bin/bash

###############################################################################
# Name: apigw_container.sh
###############################################################################
# Description:
# Build script to create the docker contaniner for API Gateway
# Docker container based on is:micro Image.
###############################################################################
# Input:
# Check help apigw_container.sh -h
# This script is dependent on is_container.sh script
###############################################################################
# Output:
# API Gateway Docker image
###############################################################################

#set -x
set -e

###############################################################################
# Variable  Declaration
###############################################################################

cmdFlag=0
instanceName=default
updatePathScript=apigw_updatePath.sh
updateNodeScript=apigw_updateNode.sh
updateUIPropsScript=apigw_updateUIProps.sh
SAG_DOCKER_HOME=/opt/softwareag
operatingSystemImage=centos:8
imageName=is:apigw
isImageName=is:micro
externES=0
keepESdata=0
externKibana=0
leanImage=0
createUser="true"
targetConfiguration=""
buildStage="buildStage"

###############################################################################
# Function   Declaration
###############################################################################

# Usage of this script
usage(){
  echo "Usage:$0 args"
  echo "args:"
  echo "createDockerfile         -   Creates a Dockerfile for API Gateway based on Integration Server instance"
  echo "    --instance.name          name of Integration Server instance for which to create an image - optional, default is"
  echo "                              the instance named default"
  echo "    --port.list              comma-separated list of ports that need to be exposed in a Docker container - default is 9072"
  echo "    --base.image             name of base Integration Server image upon which this image should be built - default is is:micro"
  echo "    --file.name              filename for the generated Dockerfile - optional, default is Dockerfile_IS_APIGW. Dockerfile is"
  echo "                              created under ${WM_HOME}/IntegrationServer/instances/{instancename}/packages"
  echo "    --keep.ES.data           Keep Elasticsearch data from installation - default is false"
  echo "    --extern.ES              Use an external Elasticsearch - default is false"
  echo "    --extern.Kibana          Use an external Kibana - default is false"
  echo "    --target.configuration   Target configuration for which Dockerfile is created - optional, default will build a Dockerfile for"
  echo "                              Docker and Kubernetes environment, specify 'OpenShift' for an OpenShift environment"
  echo "    --os.image               name of base operating system image upon which this image should be built - default is centos:8"
  echo "                              only needed if '--target.configuration OpenShift' is specified"
  echo "    --lean.image             Create a lean image - the IS Dockerfile was created using createLeanDockerfile - default is false"
  echo "    --image.createUser       Create the sagadmin user & group - default is true"
  echo "build                    -   Executes Docker build by using the provided Dockerfile to build an image of API Gateway"
  echo "    --instance.name          name of Integration Server instance for which to build an image - optional, default is"
  echo "                              the instance named default"
  echo "    --file.name              filename of the Dockerfile for build - optional, default is Dockerfile_IS_APIGW"
  echo "                             build uses the file located in the packages directory of specified instance, specifically:"
  echo "                              Integration Server_directory/instances/{instancename}/packages"
  echo "    --image.name             name for the generated image for API Gateway - optional, default is is:apigw"
  echo "-v|--version             -   Version of the script"
  echo "-h|--help                -   Show this help message"
  exit 1
}

#=========================================================================================================================================

# Parse input arguments
parseArgs(){
  
  while test $# -ge 1; do
    arg=$1
    shift
    case $arg in
      createDockerfile)
        cmdFlag=1
        dockerFile=Dockerfile_IS_APIGW
        packageName=WmAPIGateway
        portList=9072
      ;;
      build)
        cmdFlag=2
        dockerFile=Dockerfile_IS_APIGW
      ;;
      --base.image)
        isImageName=${1}
        shift
      ;;
      --os.image)
        operatingSystemImage=${1}
        shift
      ;;
      --file.name)
        dockerFile=${1}
        shift
      ;;
      --image.name)
        imageName=${1}
        shift
      ;;      
      --instance.name)
        instanceName=${1}
        shift
      ;;
      --port.list)
        portList=${1}
        shift
      ;;
      --extern.ES)
        externES=1
      ;;
      --keep.ES.data)
        keepESdata=1
      ;;
      --extern.Kibana)
        externKibana=1
      ;;
      --lean.image)
        leanImage=1
      ;;
      --image.createUser)
        value=${1}
        if [ "${value,,}" != "true" ]
        then
            createUser="false"
        fi
        shift
      ;;
      --target.configuration)
        targetConfiguration=${1}
        shift
      ;;
      -h|--help)
        usage
      ;;
      -v|--version)
        echo "$0 version 10.2"
        exit 0
      ;;
      *)
        echo "Unknown: $@"
        usage
      ;;
    esac
  done
}

#=========================================================================================================================================

createDockerfile() {
#   Create the APIGW container Dockerfile
    CHOWN="--chown=1724:1724"

    if [ "${targetConfiguration,,}" == "openshift" ]
    then
        createDockerfileForOpenShift
    else
        createDockerfileBasic
    fi
}

#=========================================================================================================================================

createDockerfileBasic() {

    createInitialDockerfile
    adaptPackagePath
    handleExternES
    handleVarious
    handleHealthCheck
    handleUser
    handleEntryPoint
    handleGatewayPorts
}

#=========================================================================================================================================

createDockerfileForOpenShift() {

    createInitialDockerfile
  
    sed -i -e "/^FROM/ s/$/ AS $buildStage/" ${IS_HOME}/instances/$instanceName/packages/$dockerFile
    
    adaptPackagePath
    handleExternES
    handleVarious

    cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile

USER root
RUN chgrp -R 0 /opt/softwareag/ && chmod -R g=u /opt/softwareag/
EOF

    handleUser

    cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile

FROM $operatingSystemImage

MAINTAINER Software AG

ENV SAG_HOME      /opt/softwareag
ENV INSTANCE_NAME $instanceName
ENV JAVA_HOME     \${SAG_HOME}/jvm/jvm/
ENV JRE_HOME      \${SAG_HOME}/jvm/jvm/
EOF

if [ $createUser == "true" ]
then
    cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
RUN groupadd -g 1724 sagadmin; useradd -u 1724 -m -g 1724 -d \${SAG_HOME} sagadmin
EOF
fi

    cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
RUN chgrp 0 /opt/softwareag/ && chmod g=u /opt/softwareag/

USER 1724

COPY --from=$buildStage --chown=1724:0 /opt/softwareag /opt/softwareag

EOF

    handleIsPorts
    handleGatewayPorts
    handleHealthCheck
    handleEntryPoint
}

#=========================================================================================================================================

createInitialDockerfile() {
    ./is_container.sh createPackageDockerfile -Dimage.createUser=true -Dpackage.list=$packageName -Dimage.name=$isImageName -Dinstance.name=$instanceName -Dfile.name=$dockerFile
}

#=========================================================================================================================================

adaptPackagePath () {  

    sed -i -e '/^ENTRYPOINT/d' \
           -e "s#^COPY ${CHOWN} ./$packageName/#COPY ${CHOWN} ./IntegrationServer/instances/\${INSTANCE_NAME}/packages/$packageName#g" \
    ${IS_HOME}/instances/$instanceName/packages/$dockerFile
}

#=========================================================================================================================================

handleExternES() {

    if [ $externES -ne 0 ]
    then
        echo "ENV EXTERN_ELASTICSEARCH true" >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
    else
        echo "RUN echo intercopy echo 1" >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
        echo "COPY ${CHOWN} ./InternalDataStore ${SAG_DOCKER_HOME}/InternalDataStore/" >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
    fi
}

#=========================================================================================================================================

handleVarious() {
  
cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
RUN echo intercopy echo 2
COPY ${CHOWN} ./common/runtime/bundles/spm/eclipse/plugins ${SAG_DOCKER_HOME}/common/runtime/bundles/spm/eclipse/plugins/
RUN echo intercopy echo 3
COPY ${CHOWN} ./common/lib/ext/* ${SAG_DOCKER_HOME}/common/lib/ext/
RUN echo intercopy echo 4
COPY ${CHOWN} ./profiles/IS_\${INSTANCE_NAME}/bin/$updatePathScript ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/bin/
COPY ${CHOWN} ./profiles/IS_\${INSTANCE_NAME}/bin/$updateNodeScript ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/bin/
COPY ${CHOWN} ./profiles/IS_\${INSTANCE_NAME}/bin/$updateUIPropsScript ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/bin/
COPY ${CHOWN} ./profiles/IS_\${INSTANCE_NAME}/configuration ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/configuration
COPY ${CHOWN} ./profiles/IS_\${INSTANCE_NAME}/apigateway  ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/apigateway
COPY ${CHOWN} ./profiles/IS_\${INSTANCE_NAME}/workspace ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/workspace

RUN rm -f ${SAG_DOCKER_HOME}/IntegrationServer/instances/\${INSTANCE_NAME}/config/clusteruuid.dat ${SAG_DOCKER_HOME}/IntegrationServer/instances/\${INSTANCE_NAME}/config/backup/clusteruuid.dat

RUN chmod a+x ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/bin/*.sh && ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/bin/$updatePathScript; \\
    sed -i '/console.sh/i . ${SAG_DOCKER_HOME}/profiles/IS_\$INSTANCE_NAME/bin/$updateNodeScript' ${SAG_DOCKER_HOME}/IntegrationServer/bin/startContainer.sh

RUN sed -i -e '/console.sh/i JL=""\nif [ "\$JSON_LOGGING" = true ] ; then JL="-logformat json" ; fi\n . ${SAG_DOCKER_HOME}/profiles/IS_\$INSTANCE_NAME/bin/$updateUIPropsScript' -e 's/-log both/-log both \$JL/g' ${SAG_DOCKER_HOME}/IntegrationServer/bin/startContainer.sh


RUN chmod a+x ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/apigateway/filebeat/filebeat_apigateway
RUN chmod 755 ${SAG_DOCKER_HOME}/profiles/IS_\${INSTANCE_NAME}/apigateway/filebeat/filebeat_apigateway.yml

RUN sed -i '/apigw.console.log/c\apigw.console.log = true' /opt/softwareag/profiles/IS_\${INSTANCE_NAME}/apigateway/config/uiconfiguration.properties
EOF

}

#=========================================================================================================================================

handleHealthCheck() {

    echo ""                                                                                     >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
    echo "HEALTHCHECK --interval=200s CMD curl -f http://localhost:5555/rest/apigateway/health" >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
}

#=========================================================================================================================================

handleUser() {

    echo ""          >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
    echo "USER 1724" >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile
}

#=========================================================================================================================================

handleEntryPoint() {

cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile

ENTRYPOINT ["${SAG_DOCKER_HOME}/IntegrationServer/bin/startContainer.sh"]
EOF

}

#=========================================================================================================================================

handleGatewayPorts() {

cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile

EXPOSE `echo $portList | tr "," " "`
EOF

}

#=========================================================================================================================================
# inspect the base image (default is:micro) and determine the exposed IS ports

handleIsPorts() {
    
    isPortList=`docker inspect --format='{{range $p, $conf := .Config.ExposedPorts}} {{$p}} {{end}}' $isImageName | sed "s#/tcp##g"`
    
cat << EOF >> ${IS_HOME}/instances/$instanceName/packages/$dockerFile

EXPOSE `echo $isPortList`
EOF

}

#=========================================================================================================================================

buildImage() {

# Build Docker image based on APIGW Docker file 
  docker build -f ${IS_HOME}/instances/$instanceName/packages/$dockerFile -t $imageName ${WM_HOME}
  rm -f ${WM_HOME}/.dockerignore
  #rm -f ${WM_HOME}/profiles/IS_${instanceName}/bin/$updatePathScript
  #rm -f ${WM_HOME}/profiles/IS_${instanceName}/bin/$updateNodeScript
}

#=========================================================================================================================================

updatePathScript() {

echo "Info: Create ${WM_HOME}/profiles/IS_${instanceName}/bin/$updatePathScript"
cat << EOF > ${WM_HOME}/profiles/IS_${instanceName}/bin/$updatePathScript
#!/bin/bash
#Software AG Installer API Gateway Image script created on @ `date` 

SAG_HOME=${SAG_DOCKER_HOME}

replacePathsInFiles() {
    for file in \`find \${SAG_HOME} -type f -exec grep -il "\${SAG_HOME_ORIG}" {} \; | grep -vE "\.log|\.jar"\`
    do
       echo "$updatePathScript: update the path in \$file"
       sed -i "s!\${SAG_HOME_ORIG}/!\${SAG_HOME}/!g" \$file
    done
}

if [ "${WM_HOME}" != "${WM_HOME_FULL}" ]
then
    SAG_HOME_ORIG=${WM_HOME_FULL}
    replacePathsInFiles
fi
SAG_HOME_ORIG=${WM_HOME}
replacePathsInFiles
EOF
}

#=========================================================================================================================================

updateUIPropsScript() {

echo "Info: Create ${WM_HOME}/profiles/IS_${instanceName}/bin/$updateUIPropsScript"
cat << EOF > ${WM_HOME}/profiles/IS_${instanceName}/bin/$updateUIPropsScript
#!/bin/bash
# Depending on the environment variable JSON_LOGGING it changes uiproperties to enable logging in json format

SAG_HOME=${SAG_DOCKER_HOME}

if [ "\$JSON_LOGGING" = true ] ; then
   sed -i '/apigw.logging.json/c\apigw.logging.json = true' \${SAG_HOME}/profiles/IS_${instanceName}/apigateway/config/uiconfiguration.properties
   sed -i -e '/wrapper.console.format/c\wrapper.console.format=M' -e '/wrapper.logfile.format/c\wrapper.logfile.format=M' \${SAG_HOME}/profiles/IS_${instanceName}/configuration/wrapper.conf
fi
EOF
}


#=========================================================================================================================================

updateNodeScript() {

echo "Info: Create ${WM_HOME}/profiles/IS_${instanceName}/bin/$updateNodeScript"
cat << EOF > ${WM_HOME}/profiles/IS_${instanceName}/bin/$updateNodeScript
#!/bin/bash

SAG_HOME=${SAG_DOCKER_HOME}
STATFILE=/tmp/init_container
LOGFILE=\${SAG_HOME}/IntegrationServer/instances/${instanceName}/logs/updateNode.log

if [ ! -d "\${SAG_HOME}/IntegrationServer/instances/${instanceName}/logs" ]
then
    mkdir "\${SAG_HOME}/IntegrationServer/instances/${instanceName}/logs"
fi

touch \$LOGFILE

if [ -f \$STATFILE ]
then
   :
else   
   \${JAVA_HOME}/bin/java -cp \${SAG_HOME}/IntegrationServer/instances/${instanceName}/packages/WmAPIGateway/bin/lib/apigateway-tools.jar com.softwareag.apigateway.tools.docker.ModifyExternalProperties ${instanceName} | tee \${LOGFILE}
   
   touch \$STATFILE
fi

current_user=\$(whoami)

if [ -z \$current_user ]
then
    current_user=\$(id -u)
fi

if [ -n \$current_user ]
then
    thisDir=\$(pwd)
    echo "current user = \$current_user, applying chown to filebeat_apigateway.yml"
    cd \${SAG_HOME}/profiles/IS_${instanceName}/apigateway/filebeat
    cp filebeat_apigateway.yml filebeat_apigateway.yml_copy
    rm filebeat_apigateway.yml
    mv filebeat_apigateway.yml_copy filebeat_apigateway.yml

    # reset to original directory, as this script is called via dot command
    cd \${thisDir}
else
    echo "Cannot determine current user, starting filebeat for log aggregation might fail"
fi

chmod 755 \${SAG_HOME}/profiles/IS_${instanceName}/apigateway/filebeat/filebeat_apigateway.yml
EOF

}

#=========================================================================================================================================

createDockerIgnore() {

echo "Info: Create ${WM_HOME}/.dockerignore"
cat << EOF > ${WM_HOME}/.dockerignore
#Software AG Installer API Gateway Image script created on @ `date` 
**/logs/*.log
**/org.eclipse.osgi
_documentation
common/bin
common/lib
!common/lib/ext
common/runtime/bundles
!common/runtime/bundles/spm
install
Apama
ApamaCapitalMarketsFoundation
Applinx
Broker
CentraSite
CloudStreamsAnalytics
CommandCentral
CSP Light
Developer
Designer
EntireX
InfrastructureDC
MashZoneNG
MWS
PlatformManager
Solutions
Terracotta
TerracottaDB
UniversalMessaging
UpdateManager
Zementis
profiles/SPM
profiles/InfraDC
profiles/MWS_default
profiles/CTP
profiles/IS_${instanceName}/apigateway/dashboard/bin/core.*
profiles/IS_${instanceName}/configuration/org.eclipse.osgi
profiles/IS_${instanceName}/logs
IntegrationServer/config
IntegrationServer/packages
IntegrationServer/sdk
IntegrationServer/web
IntegrationServer/instances/template.zip
IntegrationServer/instances/${instanceName}/config/backup
IntegrationServer/instances/${instanceName}/config/repository4.cnf
IntegrationServer/instances/${instanceName}/config/work
IntegrationServer/instances/${instanceName}/WmRepository4
IntegrationServer/instances/${instanceName}/DocumentStore
IntegrationServer/instances/${instanceName}/XAStore
IntegrationServer/instances/${instanceName}/logs
IntegrationServer/instances/${instanceName}/packages/WmRoot/pub/doc
IntegrationServer/instances/${instanceName}/packages/WmAssetPublisher/pub/doc
EOF

if [ $keepESdata -eq 0 ]
then
    echo "InternalDataStore/data" >> ${WM_HOME}/.dockerignore
fi

if [ $externKibana -ne 0 ]
then
    cat << EOF >> ${WM_HOME}/.dockerignore
profiles/IS_${instanceName}/apigateway/dashboard/node_modules
profiles/IS_${instanceName}/apigateway/dashboard/src
profiles/IS_${instanceName}/apigateway/dashboard/node
profiles/IS_${instanceName}/apigateway/dashboard/built_assets
EOF
fi

}

#=========================================================================================================================================
# Main Declaration
#=========================================================================================================================================

main(){

   cd `dirname $0`
   SCRIPTDIR=`pwd`
   DOCKER_DIR=${SCRIPTDIR}/
   IS_HOME=${DOCKER_DIR}..
   cd ${IS_HOME}/..
   WM_HOME=`pwd`
   WM_HOME_FULL=`pwd -P`
   cd $SCRIPTDIR
   
   COMMON_LIB_EXT_DIR=${WM_HOME}/common/lib/ext

   . ${WM_HOME}/install/bin/setenv.sh

   # Parse input arguments
   parseArgs "$@"
   
   case $cmdFlag in
      1)
        updatePathScript
        updateNodeScript
		updateUIPropsScript
        createDockerfile
        createDockerIgnore
      ;;
      2)
        createDockerIgnore
        buildImage
      ;; 
      *)
        echo "Error: Please enter a valid option."
        usage
      ;;
    esac
}

# Call the main function with all arguments passed in...
main "$@"
