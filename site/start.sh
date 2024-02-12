#!/bin/sh

set -e

ulimit -c unlimited

make
swebs -s /site/sitefile -o /dev/stdout
