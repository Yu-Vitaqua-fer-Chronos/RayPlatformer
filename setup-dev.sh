#!/bin/sh

nimble install https://github.com/enthus1ast/nim-chipmunk

git submodule update --init --recursive
cd naylib
git checkout -b oldcommit bc2437a438617b72b527f4d8700516981530ca2a
nim r nayget build

cd ../chipmunk
cmake .
make
mv src/libchipmunk.so ../libchipmunk.so