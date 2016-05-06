#!/bin/bash
echo "ASSEMBLING $1.s"
as $1.s -o $1.o
echo "LINKING $1.o"
ld $1.o -o $1
echo "RUNNING $1"
./$1
echo "RET STATUS=$?"

