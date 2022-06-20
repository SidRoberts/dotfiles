#!/usr/bin/env bash

set -e

mkdir -p /tmp/download-iso/

cd /tmp/download-iso/

arch_mirror="https://ftp.lanet.kr/pub/archlinux/iso/latest/"

version=$(curl -s ${arch_mirror}/arch/version)

file="archlinux-${version}-x86_64.iso"

echo "Downloading Arch Linux (${version}) iso..."

curl -O ${arch_mirror}/${file}

expected_sha256sum=$(curl -s ${arch_mirror}/sha256sums.txt | grep $file | cut -d " " -f 1)
actual_sha256sum=$(sha256sum ${file} | cut -d " " -f 1)

if [ "${expected_sha256sum}" != "${actual_sha256sum}" ]; then
    echo "SHA256 sums do not match."
    rm ${file}
    exit 1
fi

mv ${file} ~/ISOs/
