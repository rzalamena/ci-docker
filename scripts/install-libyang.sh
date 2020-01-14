#!/bin/bash
#
# Copyright (c) 2020 Network Device Education Foundation, Inc. ("NetDEF")
#                                        Rafael F. Zalamena
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

# Create build directory and switch to it.
mkdir /build
cd /build

# Download/extract libyang release.
curl -#L \
    https://github.com/CESNET/libyang/archive/v${LIBYANG_VERSION}.tar.gz \
    | tar -xvzf -

# Build and install libyang.
cd libyang-${LIBYANG_VERSION}
mkdir build
cd build
cmake \
    -D ENABLE_LYD_PRIV=1 \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/usr \
    ..

make -j$JOB_NUMBER
make install

exit 0
