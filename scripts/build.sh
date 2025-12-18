#!/usr/bin/env bash

# This contains all the common build steps needed before packaging or installing the mod

# Exit if not running under bash
if [ -z "$BASH_VERSION" ]; then
    echo "This script must be run with bash" >&2
    exit 1
fi

mod_name=$(yq -p xml -oy ".Mod.Properties.Name" src/*.modinfo)
mod_version=$(yq -p xml -oy ".Mod.+@version" "src/${mod_name}.modinfo")
mod_name_version="$(echo "${mod_name} (v ${mod_version})")"

echo "Updating mod file checksums ..."
pushd src > /dev/null
# Override IFS (internal field separator) in order to handle files with spaces in name
original_IFS="$IFS"
IFS=$'\n'
for filename in $(find . -type f | cut -c 3-); do
    new_md5sum=$(md5sum "$filename" | awk '{print $1}')
    old_md5sum=$(grep "$filename" "${mod_name}.modinfo" | head -n 1 | awk '{print $2}' | cut -c 6- | rev | cut -c 2- | rev)
    if [[ -n $old_md5sum ]]; then
        sed -i "s@${old_md5sum}\(.*${filename}\)@${new_md5sum}\1@" "${mod_name}.modinfo"
    fi
done
IFS="$original_IFS"
popd > /dev/null

echo "Preparing temporary build directory ..."
temp_dir=$(mktemp -d -p $(pwd))
cp -ar src/. "${temp_dir}"
pushd "${temp_dir}" > /dev/null
mv "${mod_name}.modinfo" "${mod_name_version}.modinfo"
# Lower-case filenames in the .modinfo file so the entry will match after we lower-case
# the filename in the file system. This is required for Linux Steam workshop compatibility.
sed -i '/<File/s|>\(.*\)<|\L&|' "${mod_name_version}.modinfo"
sed -i '/<UpdateDatabase>/s|>\(.*\)<|\L&|' "${mod_name_version}.modinfo"
sed -i '/<EntryPoint/s|file="\([^"]*\)"|file="\L\1"|' "${mod_name_version}.modinfo"
# Lower-case all file names for cross-platform compatibility, particularly Linux (https://stackoverflow.com/a/152741)
find . -depth -name '*[A-Z]*'|sed -n 's/\(.*\/\)\(.*\)/mv -n -T "\1\2" "\1\L\2"/p'|sh
popd > /dev/null
