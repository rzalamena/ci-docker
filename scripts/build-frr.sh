#!/bin/bash
#
# Copyright (c) 2020 Network Device Education Foundation, Inc. ("NetDEF")
#                    Rafael F. Zalamena
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

# Load environment variables and common functions.
. "$(dirname "$0")/common.sh"

# Exit on any command failure.
set -e

# Run bootstrap.
./bootstrap.sh

# Configure FRR build.
./configure \
    --enable-doc \
    --enable-multipath=64 \
    --enable-fpm \
    --prefix=/usr \
    --localstatedir=/var/run/frr \
    --sysconfdir=/etc/frr \
    --enable-exampledir=/usr/share/doc/frr/examples \
    --sbindir=/usr/lib/frr \
    --enable-user=frr \
    --enable-group=frr \
    --enable-vty-group=frrvty \
    --enable-snmp=agentx \
    --enable-sharpd \
    --enable-vrrpd \
    --enable-configfile-mask=0640 \
    --enable-logfile-mask=0640 \
    --enable-dev-build \
    --enable-systemd=yes \
    --with-pkg-git-version

# Compile everything.
make -j$JOB_NUMBER

# Attempt to install.
make install

exit 0
