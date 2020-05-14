#!/bin/sh

if ! docker build --rm -t webysther/aws-glue-docker:spark-1.0-py3 src/spark/1.0/py3; then
    exit
fi

if ! docker build --rm -t webysther/aws-glue-docker:spark-1.0-py2 src/spark/1.0/py2; then
    exit
fi

if ! docker build --rm -t webysther/aws-glue-docker:spark-0.9 src/spark/0.9; then
    exit
fi

if ! docker build --rm -t webysther/aws-glue-docker:shell-py3 src/shell/py3; then
    exit
fi

if ! docker build --rm -t webysther/aws-glue-docker:shell-py2 src/shell/py2; then
    exit
fi
