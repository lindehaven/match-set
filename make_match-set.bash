#!/usr/bin/env bash
OPT='-O2 -Wall -s -o'
BIN='bin/Release/match-set.exe'
SRC='src/match_set.c'
mkdir -p bin
mkdir -p bin/Release
echo "gcc $OPT $BIN $SRC"
      gcc $OPT $BIN $SRC
