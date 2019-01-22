#!/usr/bin/env bash

override=./conf/override.bionic

touch $override

# add overriding

pre_depend=$(ls ./packages/pre_depend_packages)
depend=$(ls ./packages/depend_packages)
target=$(ls ./packages | grep "deb")

for i in $pre_depend ; do
    sudo reprepro --ignore=forbiddenchar includedeb bionic ./packages/pre_depend_packages/$i
done

for i in $depend ; do
    sudo reprepro --ignore=forbiddenchar includedeb bionic ./packages/depend_packages/$i  
done

sudo reprepro includedeb bionic ./packages/$target
