#!/bin/bash
set -e

# The install.sh script is the installation entrypoint for any features in this repository.
#
# The tooling will parse the features.json + user devcontainer, and write
# any build-time arguments into a feature-set scoped "features.env"
# The author is free to source that file and use it however they would like.
set -a
. ./features.env
set +a


if [ ! -z ${_BUILD_ARG_AWSCLI} ]; then
    echo "Activating feature 'awscli'"

    # Build args are exposed to this entire feature set following the pattern:  _BUILD_ARG_<FEATURE ID>_<OPTION NAME>
    AWSCLI_VERSION=${_BUILD_ARG_AWSCLI_VERSION:-undefined}

    echo "Downloading AWS CLI for ${AWSCLI_VERSION}..."
    curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
    echo "Downloading AWS CLI is done."
    cd /tmp
    unzip awscliv2.zip
    sudo ./aws/install
fi
