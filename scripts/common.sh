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

#
# Functions.
#
log_msg() {
	local msg="$*"

	echo % "$msg"
}

#
# Environment setup.
#

# Enable/disable verbosity based on CI system signal.
if [ $bamboo_ci_script_verbose ]; then
	set -x
fi

# Learn current OS information.
OS=$(uname)
if [ "$OS" == "Linux" ]; then
	if [ -f /etc/os-release ]; then
		. /etc/os-release
	else
		NAME=unknown
		ID=unknown
		VERSION_ID=unknown
	fi
else
	NAME=$OS
	ID=$OS
	VERSION_ID=$(uname -r)
fi

# Example of OS output:
# ubuntu-20.04, ubuntu-18.04, etc...
OS="${ID}-${VERSION_ID}"

# Use the more friendly name JOB_NUMBER instead of bamboo's environment name.
if [ "x$bamboo_capability_buildnode_cpus" == "x" ]; then
	JOB_NUMBER=1
else
	JOB_NUMBER=$bamboo_capability_buildnode_cpus
fi

LIBYANG_VERSION="1.0-r4"

# Don't ever exit here, otherwise scripts sourcing this will also quit.
