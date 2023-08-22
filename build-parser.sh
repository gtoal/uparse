#!/bin/bash
if [ $# != 1 ] ; then
  echo "syntax: build-parser projname"
  exit 0
fi
if [ -f Makefile ] ; then
  OLDLANG=( `fgrep "LANGUAGE := " Makefile | head -1` )

  if [ "${OLDLANG[2]}" = "" ] ; then
    echo Saving previous Makefile as \'Makefile-$$\'
    mv Makefile Makefile-$$
  else
    if [ -f Makefile-${OLDLANG[2]} ] ; then
      echo Saving previous Makefile as \'Makefile-${OLDLANG[2]}-$$\'
      mv Makefile Makefile-${OLDLANG[2]}-$$
    else
      echo Saving previous Makefile as \'Makefile-${OLDLANG[2]}\'
      mv Makefile Makefile-${OLDLANG[2]}
    fi
  fi
fi

echo Creating Makefile for project \'$1\'
( echo LANGUAGE := $1; cat skeleton-Makefile ) > Makefile
cp skeleton-compile.c $1.c

if [ ! -f  $1.g ] ; then
  if [ ! -f  test.$1 ] ; then
    echo Now you should create a $1.g grammar file and a test.$1 input file, then type: make
  else
    echo Now you should create a $1.g grammar file, then type: make
  fi
elif [ ! -f  test.$1 ] ; then
    echo Now you should create a test.$1 input file, then type: make
fi
exit 0
