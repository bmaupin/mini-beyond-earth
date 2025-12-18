#!/usr/bin/env bash

# Exit if not running under bash
if [ -z "$BASH_VERSION" ]; then
    echo "This script must be run with bash" >&2
    exit 1
fi

# Build the mod in a temporary directory
source "$(dirname "$(which "$0")")/build.sh"

# Clean up previous mod package
rm -f "${mod_name_version}.civbemod"

echo "Creating mod package ..."
pushd "${temp_dir}" > /dev/null
# Delete any previously-created mod packages, otherwise the script will add to them
rm -f ../"$(echo "${mod_name} (v ${mod_version})" | tr '[:upper:]' '[:lower:]').civbemod"
# Write the .civbemod file with a lower-case filename as well. This isn't necessary but
# is more consistent and will make the manual installation instructions less confusing.
7z a -r ../"$(echo "${mod_name} (v ${mod_version})" | tr '[:upper:]' '[:lower:]').civbemod" *
popd > /dev/null
rm -rf "${temp_dir}"
