#!/bin/bash

echo -e "---------------------------- AWS Client VPN Helper ----------------------------\n"

# Load variables from Configuration file
. variables.cfg

# Check that all variables are available
REQUIRED_ARGUMENTS=("WORKDIR" "OVPNCFGFILE")

for REQUIRED in ${REQUIRED_ARGUMENTS[@]}; do
    if [ -z $(eval echo \$$REQUIRED) ]; then
        echo -e " ERROR: Configuration is missing the argument $REQUIRED.\n \
Required variables are ${REQUIRED_ARGUMENTS[@]}."; exit 1
    fi
done

# Make sure the working directory has correct
if [ -f "$WORKDIR/`basename "$0"`" ]; then
    cd $WORKDIR
else
    echo " ERROR: The working directory doesn't look valid. \
    Please make sure you update variables.cfg"; exit 1
fi

# Operational Function

function clean-up-keys {
    echo -e "Cleanup all the local Certificates & Keys, and downloaded Software\n"
    rm -fr ./easy-rsa
    rm -fr ./pki
    rm $OVPNCFGFILE 2> /dev/null
    echo -e "Proceedure completed."
}

# Main Execution

read -p "Do you want to cleanup the local Certificates & Keys, and downloaded Software? [y/n] " createopt

if [ "$createopt" == "y" ] || [ "$createopt" == "yes" ]; then
    clean-up-keys
else
    echo "Exiting"; exit
fi


