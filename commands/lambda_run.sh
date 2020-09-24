#!/bin/sh

PYTHON_IMAGE=python3.7
PARAM_JSON=lambda_param.json
ENV_FILE=lambda_docker.env

docker run --rm --env-file "$PWD"/$ENV_FILE -v "$PWD":/var/task lambci/lambda:$PYTHON_IMAGE lambda_function.lambda_handler $(printf '%s' $(cat $PARAM_JSON))

