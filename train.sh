#!/bin/sh

set -x

export PYTHONPATH="`pwd`/tensorflow_models/research:$PYTHONPATH"
export PYTHONPATH="`pwd`/tensorflow_models/research/slim:$PYTHONPATH"

protoc protos/*.proto --python_out=. || exit -1

mkdir -p log

export CUDA_VISIBLE_DEVICES=2
name="448"
python train/trainer_main.py \
  --pipeline_proto="configs/${name}.pbtxt" \
  --logtostderr >> log/${name}.log 2>&1 &

exit 0