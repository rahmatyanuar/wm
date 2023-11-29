#!/bin/bash
# Usage: ./apigw_process_duplicate_bundle_jars.sh [/opt/softwareag]
# Used to produce a Dockerfile to remove lower versioned jars
# assume that jars are listed in numerically sorted order with most recent last
# earlier jars are listed for .dockerignore inclusion

JARSFILE="bundle-jars-sorted.txt"
DOCKERFILE="Dockerfile_APIGW"

# jar name without digits
REMVER=

IGNORE_JARS="com.softwareag.security.sin.idp.saml1 com.softwareag.security.sin.idp.saml2"
IGNORE_LINES=($(echo ${IGNORE_JARS} | tr " " "\n"))

# remove digits from jar name
function removeVersion() {
    TEXT=$1
    REMVER=`echo $TEXT | sed -e 's/[0-9][0-9]*/X/g'`
}

# previous line
PREV=

# check current line against previous
function checkVersionedJars() {
    LINE=$1

    for IGNORE in "${IGNORE_LINES[@]}"
    do
        if [[ "$LINE" =~ "/${IGNORE}" ]]
        then
            return 0
        fi
    done

    if [ -n "$PREV" ]
    then
        removeVersion $PREV
        PREVJAR=$REMVER
        removeVersion $LINE
        CURRJAR=$REMVER
        if [ $PREVJAR = $CURRJAR ]
        then
            echo "  $PREV \\"
        fi
    fi
    PREV=$LINE
}

function processSortedBundleJars() {
    echo "RUN rm -f \\" >> $DOCKERFILE
    while read line
    do
        checkVersionedJars $line
    done < $JARSFILE >> $DOCKERFILE
    echo "non-existent.jar" >> $DOCKERFILE
}

SAG_DIR=/opt/softwareag

if [ $# -ge 1 ]
then
    SAG_DIR="$1"
fi

find ${SAG_DIR}/common/runtime/bundles -name '*.jar' | sort > $JARSFILE
echo "EOF" >> $JARSFILE

echo "FROM is:apigw" > $DOCKERFILE
processSortedBundleJars
