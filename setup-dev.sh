#!/bin/sh

nimble install https://github.com/enthus1ast/nim-chipmunk nake --accept

git submodule update --init --recursive

cd naylib
nake buildDesktop

cd ../chipmunk
cmake .
make
mv src/libchipmunk* ..