#!/bin/bash

set -e
set -x

THIS_DIR=`pwd`
GENIMAGE_TMP="${THIS_DIR}/genimage.tmp"

rm -rf "${GENIMAGE_TMP}"

#trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
#ROOTPATH_TMP="$(mktemp -d)"

genimage \
    --rootpath "${THIS_DIR}/root" \
    --tmppath "${GENIMAGE_TMP}" \
    --inputpath "${THIS_DIR}" \
    --outputpath "${THIS_DIR}" \
    --config genimage-bios.cfg


