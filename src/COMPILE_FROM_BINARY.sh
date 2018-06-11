#!/usr/bin/env bash
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

echo $TF_INC
echo $TF_LIB

CPP=g++
ARGS="-D_GLIBCXX_USE_CXX11_ABI=0"
OS=$(uname)
if [ "$OS" = "Darwin" ]; then
  CPP=clang++
  ARGS="-undefined dynamic_lookup"
fi

$CPP -std=c++11 $ARGS -shared shuffle_op.cc -o shuffle_op.so -fPIC -I $TF_INC -I$TF_INC/external/nsync/public -L$TF_LIB -ltensorflow_framework -O2
