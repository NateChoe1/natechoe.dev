#!/bin/sh

ulimit -c unlimited 2>&1
make
swebs -s /site/sitefile -o /dev/stdout
