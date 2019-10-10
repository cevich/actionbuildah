#!/bin/bash

set -e


die() {
    # Ref: https://help.github.com/en/articles/development-tools-for-github-actions#set-an-error-message-error
    echo "::error file=${BASH_SOURCE[1]},line=${BASH_LINENO[0]}::${1:-No error message specified}"
    exit 1
}

# Ref: https://help.github.com/en/articles/virtual-environments-for-github-actions#environment-variables
GITHUB_ACTIONS_DEF_VARS=(\
    CONTAINER \
    HOME \
    GITHUB_WORKFLOW \
    GITHUB_ACTION \
    GITHUB_ACTOR \
    GITHUB_REPOSITORY \
    GITHUB_EVENT_NAME \
    GITHUB_EVENT_PATH \
    GITHUB_WORKSPACE \
    GITHUB_SHA \
)

for required_var in ${GITHUB_ACTIONS_DEF_VARS[@]}; do
    ERRMSG="Found required env. var. '$required_var' undefined or \
empty.  This script is intended to be executed as the main entrypoint \
of a container for a GitHub action.  Use outside this context is \
not supported and may be dangerous."
    [[ -n "${!required_var}" ]] || \
        die "$ERRMSG"
done

[[ "$CONTAINER" == "true" ]] || \
    die "The \$CONTAINER env. var. value must be 'true', not '$CONTAINER'."

[[ -d "$GITHUB_WORKSPACE/.git" ]] || \
    die "Expecting the \$GITHUB_WORKSPACE env. var. to contain a .git directory \
, found '$(ls -1a)'"

cd "$GITHUB_WORKSPACE"

[[ -z "$INPUT_ARTIFACTS_DIRPATH" ]] || \
    mkdir -vp "$INPUT_ARTIFACTS_DIRPATH"

set -x
/usr/bin/make $@
