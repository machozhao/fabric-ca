#!/bin/sh
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#


if [ "$#" -ne 3 ]; then
    echo "Prepends a changelog into the current CHANGELOG.md at the root of the project"
    echo "Note: must be run from root directory of repository clone"
    echo "Usage: ./scripts/changelog.sh <StartRefSpec> <EndRefSpec> <ReleaseVersion>"
    exit 1
fi

echo "## $3\n$(date)\n" >> CHANGELOG.new
git log $1..$2  --oneline | grep -v Merge | sed -e "s/\[\(FAB-[0-9]*\)\]/\[\1\](https:\/\/jira.hyperledger.org\/browse\/\1\)/" -e "s/ \(FAB-[0-9]*\)/ \[\1\](https:\/\/jira.hyperledger.org\/browse\/\1\)/" -e "s/\([0-9|a-z]*\)/* \[\1\](https:\/\/github.com\/hyperledger\/fabric\/commit\/\1)/" >> CHANGELOG.new
echo "" >> CHANGELOG.new
cat CHANGELOG.md >> CHANGELOG.new
mv -f CHANGELOG.new CHANGELOG.md