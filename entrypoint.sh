#!/bin/bash

set -e

# Make sure that repos contain certain files.
# Fail with an error if not.
# Checked files:
# README.md, CHANGELOG.md

# Vars
# We like colors
RED='\033[0;31m'
#GREEN='\033[0;32m'
#YELLOW='\033[0;33m'
NO_COLOR='\033[0m'
CLEAR_LINE='\r\033[K'

# Log
LOGFILE=error.log

# Markdown
CHECK_MD='README.md CHANGELOG.md'

check_md_files() {
    for file in $CHECK_MD
    do
        if [ ! -f "$file" ]; then
            echo -en "${CLEAR_LINE}❌${RED} $file ${NO_COLOR}\n"
	    echo "$file" >> $LOGFILE
    fi
    done
    if [ -f "$LOGFILE" ]; then
	echo ""
	echo ::set-output name=status::'Failed'
        echo -en "Missing files:\n"
        cat "$LOGFILE"
	rm "$LOGFILE"
	exit 1
    else
	echo ::set-output name=status::'Awesome.'
    fi
}

check_md_files

# EXIT
exit 0
