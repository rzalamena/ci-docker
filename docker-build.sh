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
. "$(dirname "$0")/scripts/common.sh"

# Exit on any command failure.
set -e

# Find all available dockerfiles.
options=$(find . -name Dockerfile -type f -exec dirname {} \+ \
    | cut -d '/' -f 2)

while [ TRUE ]; do
	echo "Available docker recipes:"
	for option in $options; do
		echo "    => $option"
	done
	log_msg "Please select one option:"

	read selection

	found=0
	for option in $options; do
		if [ $selection == $option ]; then
			found=1
			break
		fi
	done
	[ $found -eq 1 ] && break

	log_msg "Invalid option '$selection'."
	echo
done

log_msg "Generating docker image for $selection"

docker build --compress --force-rm --pull \
    --file $selection/Dockerfile --tag frr-builder-$selection \
    .

exit 0
