#!/bin/sh

nimble install https://github.com/enthus1ast/nim-chipmunk nake --accept

git clone https://github.com/Slembcke/Chipmunk2D chipmunk --depth 1
git clone https://github.com/Planetis-M/Naylib naylib --depth 1

cd naylib
nake buildDesktop

cd ../chipmunk
cmake .
make
mv src/libchipmunk* ..