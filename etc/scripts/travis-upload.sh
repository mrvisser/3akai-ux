#!/bin/bash

##
# This script will package and upload a successful build to Amazon S3. It should only
# execute under the following conditions:
#
#   * The build was performed on the oaeproject repository
#   * The build was performed on the master branch
#   * The build was not performed on a pull request to the master branch
##

EXPECTED_REPOSITORY="mrvisser/3akai-ux"
EXPECTED_BRANCH="master"
EXPECTED_PULL_REQUEST="1"

function package_and_upload {
    git reset --hard origin/master
    git checkout master
    git fetch --tags
    rm -rf target
    bin/package -su --upload-bucket=oae-releases-travis
}

echo "after success"

if [[ "$TRAVIS_REPO_SLUG" == "$EXPECTED_REPOSITORY" && "$TRAVIS_BRANCH" == "$EXPECTED_BRANCH" && "$TRAVIS_PULL_REQUEST" == "$EXPECTED_PULL_REQUEST" ]]; then
    echo "going to package and upload"
    package_and_upload
fi
