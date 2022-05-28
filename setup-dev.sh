#!/bin/sh

nimble install https://github.com/enthus1ast/nim-chipmunk

git submodule update --init --recursive
cd naylib
nim r nayget build

cd ../chipmunk
cmake .
make
mv src/libchipmunk.so ../libchipmunk.so

cd ..