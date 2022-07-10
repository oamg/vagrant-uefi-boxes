#!/usr/bin/bash

echo "Removing box"
rm -rf *.box 

echo "Running packer"
PACKER_LOG=1 packer build \
    -only=qemu.centos-84-uefi \
    centos.pkr.hcl
