#!/bin/bash

PYTHON_BUILD_IMAGE=build-python3.7
ZIP_FILE=deploy_package.zip
LAMBDA_PACKAGE=lambda-package

ESC=$(printf '\033')

function do_confirm() {

  input_msg="${ESC}[33mplease input y/n.${ESC}[m"

  echo "----------------------------"
  echo "${ESC}[32m$*${ESC}[m"
  echo $input_msg
  read input

  if [ -z $input ] ; then

    echo "${ESC}[32m $input_msg ${ESC}[m"
    do_confirm $*

  elif [ $input = 'yes' ] || [ $input = 'YES' ] || [ $input = 'y' ] || [ $input = 'Y' ]; then
    true
    return

  elif [ $input = 'no' ] || [ $input = 'NO' ] || [ $input = 'n' ] || [ $input = 'N' ] ; then
    false
    return

  else
    echo $input_msg
    do_confirm $*

  fi

}

if [ -f $ZIP_FILE ]; then

    if do_confirm "$ZIP_FILE file already exists. delete it?"; then
        rm  deploy_package.zip
        echo ${ESC}[32m$ZIP_FILE "is deleted.${ESC}[m"
    else
        echo "${ESC}[31maborted.${ESC}[m"
        exit
    fi
fi

if [ -d $LAMBDA_PACKAGE ]; then

    if do_confirm "$LAMBDA_PACKAGE dir for lambda already exists. delete it?"; then
        rm -r lambda-package
        echo "${ESC}[32m$LAMBDA_PACKAGE is deleted.${ESC}[m"
    else
        echo "${ESC}[31maborted.${ESC}[m"
        exit
    fi
fi


echo "${ESC}[32mmake requirements.txt and install package for lambda....${ESC}[m"

poetry export -f requirements.txt > requirements.txt

docker run --rm -v $(pwd):/var/task lambci/lambda:$PYTHON_BUILD_IMAGE pip3 install -r requirements.txt -t /var/task/$LAMBDA_PACKAGE
echo "${ESC}[32mpackaging done...${ESC}[m"
echo "${ESC}[32mzipping...${ESC}[m"

zip -9 $ZIP_FILE lambda_function.py
cd lambda-package
zip -r9 ../$ZIP_FILE ./*

echo "${ESC}[32mzip file [$ZIP_FILE] is created.${ESC}[m"


