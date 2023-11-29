#!/bin/sh
#=============================================================================
#
#  apigw-setenv.sh
#
#=============================================================================

TENANT_DIR="$(dirname  "$(dirname  "$(dirname  "$(dirname "$PWD")")")")"
JAR_DIR="${TENANT_DIR}/packages/WmAPIGateway/code/jars"
COMMON_LIB_DIR="$(dirname "$(dirname "$(dirname ${TENANT_DIR})")")/common/lib";
JAVA_EXE="$(dirname "$(dirname "$(dirname ${TENANT_DIR})")")/jvm/jvm/bin/java"

CLASSPATH=:${JAR_DIR}/*:${JAR_DIR}/static/*:${COMMON_LIB_DIR}/ext/*
