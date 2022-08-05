#!/usr/bin/bash

SYSTEM=$1
EXTRA_PKR_VARS=$2
PACKER_LOG=0

function cleanup() {
    rm -rf *.box
}

# Oracle Linux Setup

function setup_build_ol79() {
    export PKR_HCL_FILE=ol.pkr.hcl 
    export PKR_VARS=(
        -var="box_tag=rhel-conversions/ol-7.9-uefi" 
        -var="version=7.9" 
        $EXTRA_PKR_VARS
    )
    export PKR_ONLY=-only="qemu.ol-79-uefi"
}

function setup_build_ol84() {
    export PKR_HCL_FILE=ol.pkr.hcl 
    export PKR_VARS=(
        -var="box_tag=rhel-conversions/ol-8.4-uefi" 
        -var="version=8.4" 
        $EXTRA_PKR_VARS
    )
    export PKR_ONLY=-only="qemu.ol-84-uefi"
}

function setup_build_ol86() {
    export PKR_HCL_FILE=ol.pkr.hcl 
    export PKR_VARS=(
        -var="box_tag=rhel-conversions/ol-8.6-uefi" 
        -var="version=8.6" 
        $EXTRA_PKR_VARS
    )
    export PKR_ONLY=-only="qemu.ol-86-uefi"
}

# CentOS Linux Setup

function setup_build_centos79() {
    export PKR_HCL_FILE=centos.pkr.hcl 
    export PKR_VARS=(
        -var="box_tag=rhel-conversions/centos-7.9-uefi" 
        -var="version=7.9.2009" 
        $EXTRA_PKR_VARS
    )
    export PKR_ONLY=-only="qemu.centos-79-uefi"
}

function setup_build_centos84() {
    export PKR_HCL_FILE=centos.pkr.hcl 
    export PKR_VARS=(
        -var="box_tag=rhel-conversions/centos-8.4-uefi" 
        -var="version=8.4.2105" 
        $EXTRA_PKR_VARS
    )
    export PKR_ONLY=-only="qemu.centos-84-uefi"
}

function setup_build_centos85() {
    export PKR_HCL_FILE=centos.pkr.hcl 
    export PKR_VARS=(
        -var="box_tag=rhel-conversions/centos-8.5-uefi" 
        -var="version=8.5.2111" 
        $EXTRA_PKR_VARS
    )
    export PKR_ONLY=-only="qemu.centos-85-uefi"
}

function build() {
    echo "Building $PKR_HCL_FILE"
    packer build "${PKR_VARS[@]}" "$PKR_ONLY" "$PKR_HCL_FILE"
}

case $SYSTEM in
    centos79)
        setup_build_centos79
        ;;
    centos84)
        setup_build_centos84
        ;;
    centos85)
        setup_build_centos85
        ;;
    ol79)
        setup_build_ol79
        ;;
    ol84)
        setup_build_ol84
        ;;
    ol87)
        setup_build_ol86
        ;;
    *)
        echo "Not an viable option."
        exit 1
        ;;
esac

cleanup
build
