#!/bin/bash

# Define tests
#
tests="../test/test_files.py \
       ../test/test_packages.py"

# Run tests using testinfra
#
SCRIPTNAME=$(basename $0)
DIRNAME=$(dirname $0)

# Setup for pip virtual environment
#
export WORKON_HOME=~/.pyenvironments
mkdir -p ${WORKON_HOME}

# Install pips for python virtual environment
#
pip install virtualenv virtualenvwrapper

# Source env wrapper
#
source /usr/local/bin/virtualenvwrapper.sh

# Make a virtual environment to install new pips
#
mkvirtualenv CVtests

# Upgrade pip and install pips
#
pip install --upgrade pip
pip install testinfra paramiko

# Bring up VM ready to run tests and save ssh key for testinfra
#
(cd ${DIRNAME}/../vagrant && vagrant up wicksycv && vagrant ssh-config wicksycv > wicksycv-sshkey)

# Run tests
#
(cd ${DIRNAME}/../vagrant && testinfra -v --hosts=wicksycv --ssh-config=./wicksycv-sshkey ${tests})

# Exit from the virtual environment and clean it up
#
deactivate
rmvirtualenv CVtests

exit 0