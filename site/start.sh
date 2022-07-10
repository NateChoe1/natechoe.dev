#!/bin/sh

echo "/core/core.%e.%p" >> /proc/sys/kernel/core_pattern
ulimit -c unlimited
make
swebs -s /site/sitefile -o /dev/stdout
