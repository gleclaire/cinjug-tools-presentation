#!/usr/bin/env bash

MYDIR="$(dirname "$(which "$0")")"

PROJECT_DIR=""$(readlink -f $PWD)

echo $MYDIR

echo PROJECT_DIR

$MYDIR/run-term.py "PROJECT_DIR"

echo "Waiting for app to come alive......."

sleep 20

open http://localhost:9000

