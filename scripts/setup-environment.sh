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

# Setup user/group for FRR.
log_msg "Setting up user/group for FRR"

case $OS in
alpine-*)
	# Alpine uses different user management.
	addgroup -S frr
	addgroup -S frrvty
	adduser -S -D -h /var/run/frr -s /sbin/nologin -G frr -g frr frr
	adduser frr frrvty
	;;

centos-*)
	# CentOS has different adduser syntax.
	groupadd -r -g 92 frr
	groupadd -r -g 85 frrvty
	adduser --system --gid frr --home /var/run/frr \
	    --comment "FRR suite" --shell /sbin/nologin frr
	usermod -a -G frrvty frr
	;;

*)
	groupadd -r -g 92 frr
	groupadd -r -g 85 frrvty
	adduser --system --ingroup frr --home /var/run/frr \
	    --gecos "FRR suite" --shell /sbin/nologin frr
	usermod -a -G frrvty frr
	;;
esac

exit 0
