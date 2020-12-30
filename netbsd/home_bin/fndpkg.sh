#!/bin/sh

TARGET=/usr/pkgsrc

find ${TARGET} -type d -maxdepth 2 | grep ${1}
