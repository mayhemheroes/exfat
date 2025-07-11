#
#	configure.ac (30.03.15)
#	Autoconf source.
#
#	Free exFAT implementation.
#	Copyright (C) 2010-2023  Andrew Nayenko
#
#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 2 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License along
#	with this program; if not, write to the Free Software Foundation, Inc.,
#	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

AC_INIT([Free exFAT implementation],
	[1.4.0],
	[relan@users.noreply.github.com],
	[exfat],
	[https://github.com/relan/exfat])
AM_INIT_AUTOMAKE([1.11.2 -Wall -Werror foreign subdir-objects])
AC_PROG_CC
AC_PROG_RANLIB
AM_PROG_AR
AC_SYS_LARGEFILE
AC_CANONICAL_HOST
PKG_CHECK_MODULES([FUSE3], [fuse3],
  [AC_DEFINE([FUSE_USE_VERSION], [30], [Required FUSE API version.])],
  [PKG_CHECK_MODULES([FUSE2], [fuse >= 2.6],
    [AC_DEFINE([FUSE_USE_VERSION], [26], [Required FUSE API version.])])])
AC_MSG_CHECKING([whether host-specific configuration is needed for $host_os])
case "$host_os" in
  darwin*)
    AC_MSG_RESULT([yes])
    AC_DEFINE([FUSE_DARWIN_ENABLE_EXTENSIONS], [0], [macFUSE extensions break compatibility with the mainline FUSE.])
	;;
  freebsd*)
    AC_MSG_RESULT([yes])
    PKG_CHECK_MODULES([UBLIO], [libublio])
    AC_DEFINE([USE_UBLIO], [1], [Define if block devices are not supported.])
	;;
  *-gnu)
    AC_MSG_RESULT([yes])
    AC_DEFINE([_XOPEN_SOURCE], [500], [Enable pread() and pwrite().])
    AC_DEFINE([_DEFAULT_SOURCE], [], [Enable vsyslog().])
	;;
  *)
    AC_MSG_RESULT([no])
	;;
esac
AC_CONFIG_HEADERS([libexfat/config.h])
AC_CONFIG_FILES([
	libexfat/Makefile
	attrib/Makefile
	dump/Makefile
	fsck/Makefile
	fuse/Makefile
	label/Makefile
	mkfs/Makefile
	Makefile])
AC_OUTPUT
