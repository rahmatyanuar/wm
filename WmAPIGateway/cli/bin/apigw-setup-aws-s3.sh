#!/bin/bash

mkdir -p logs
exec > >(tee -a -i logs/setup-aws-s3.log)
exec 2>&1

echo ""
echo "$(date -Iseconds) : $0 script has been invoked with arguments $* from location $PWD "
echo "All the log file data available at ${PWD}/logs/setup-aws-s3.log"

echo -e "Welcome to setup AWS S3 as the API Gateway backup location."
sudo yum install zip unzip -y

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip

# This installs the AWS CLI to the default location (~/.local/lib/aws) and create a symbolic link (symlink) at ~/bin/aws.
./awscli-bundle/install -b ~/bin/aws

~/bin/aws --version

s3ConfigurationFile=$(readlink -f "$1")

mkdir -p ~/.aws/

s3_access_key="$(grep access_key "${s3ConfigurationFile}" | cut -f2 -d=)"
s3_secret_key="$(grep secret_key "${s3ConfigurationFile}" | cut -f2 -d=)"
s3_region="$(grep region "${s3ConfigurationFile}" | cut -f2 -d=)"

{
    echo "[default]"
    echo "aws_access_key_id=${s3_access_key}"
    echo "aws_secret_access_key=${s3_secret_key}"
} >~/.aws/credentials

{
    echo "[default]"
    echo "region=$s3_region"
} >~/.aws/config

# export PATH=$PATH:~/bin
# aws s3 ls

echo "Completed AWS S3 setup."
echo ""
