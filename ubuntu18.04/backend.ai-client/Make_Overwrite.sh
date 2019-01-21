#!/usr/bin/env bash

override=./conf/override.bionic

touch $override

# add overriding

pre_depend=$(ls ./packages/pre_depend_packages)
depend=$(ls ./packages/depend_packages)
target=$(ls ./packages | grep "deb")

for i in $pre_depend ; do
    echo "$i Priority optional" >> $override
done

for i in $depend ; do
    echo "$i Priority optional" >> $override
done

echo "$target Priority optional" >> $override
