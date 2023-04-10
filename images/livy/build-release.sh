#!/bin/bash

here=`dirname $0`
here=`realpath $here`

cd $here

podman build -t livy-build -f Containerfile-pkgbuild -v $here/cache:/root/.m2 -v $here/release:/output/
