#!/bin/sh

exec docker buildx build . -t natechoe/natechoe.dev
