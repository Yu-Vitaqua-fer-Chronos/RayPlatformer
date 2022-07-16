#!/bin/sh

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(realpath .)" nim c --run main.nim