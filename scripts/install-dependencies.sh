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

log_msg "Installing dependencies for $OS"

# Install dependencies on OS basis.
case $OS in
centos-7)
	# FRR dependencies.
	yum install -y git autoconf automake libtool readline-devel texinfo \
	    net-snmp-devel groff pkgconfig json-c-devel pam-devel bison flex \
	    python-pytest python-devel systemd-devel python-sphinx make \
	    patch diffutils libcap-devel

	# libyang dependencies.
	yum install -y cmake
	;;

centos-*)
	# FRR dependencies.
	dnf install --enablerepo=PowerTools -y git autoconf automake libtool \
	    readline-devel texinfo pcre-devel net-snmp-devel pkgconfig groff \
	    json-c-devel pam-devel bison flex c-ares-devel systemd-devel \
	    libcap-devel python3-pytest python3-devel python3-sphinx make \
	    patch diffutils
	
	# libyang dependencies.
	dnf install --enablerepo=PowerTools -y cmake
	;;

ubuntu-14.04)
	export DEBIAN_FRONTEND=noninteractive

	apt-get update

	# FRR dependencies.
	apt-get install -y git autoconf automake libtool make libreadline-dev \
	    texinfo pkg-config libpam0g-dev libjson-c-dev bison flex \
	    python3-pytest libc-ares-dev python3-dev python3-sphinx \
	    install-info build-essential libsnmp-dev perl libcap-dev

	# libyang dependencies.
	apt-get install -y curl cmake libpcre3-dev
	;;

ubuntu-*)
	export DEBIAN_FRONTEND=noninteractive

	apt-get update

	# FRR dependencies.
	apt-get install -y git autoconf automake libtool make libreadline-dev \
	    texinfo pkg-config libpam0g-dev libjson-c-dev bison flex \
	    python3-pytest libc-ares-dev python3-dev libsystemd-dev \
	    python-ipaddress python3-sphinx install-info build-essential \
	    libsnmp-dev perl libcap-dev

	# libyang dependencies.
	apt-get install -y curl cmake libpcre3-dev

	# Static analyzer dependencies.
	if [ $OS == 'ubuntu-20.04' ]; then
		apt-get install -y clang-tools
	fi
	;;

alpine-*)
	# FRR dependencies.
	apk add autoconf automake libtool build-base json-c-dev python3-dev \
	    readline-dev py3-sphinx c-ares-dev net-snmp-dev bison flex git \
	    linux-headers bsd-compat-headers libcap-dev pytest texinfo

	# libyang dependencies.
	apk add curl cmake pcre-dev
	;;
esac

exit 0
