#
#	Makefile.am (30.03.15)
#	Automake source.
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

noinst_LIBRARIES = libexfat.a
libexfat_a_SOURCES = \
	byteorder.h \
	cluster.c \
	compiler.h \
	exfat.h \
	exfatfs.h \
	io.c \
	log.c \
	lookup.c \
	mount.c \
	node.c \
	platform.h \
	repair.c \
	time.c \
	utf.c \
	utils.c
libexfat_a_CPPFLAGS = -imacros $(top_srcdir)/libexfat/config.h
libexfat_a_CFLAGS = $(FUSE2_CFLAGS) $(FUSE3_CFLAGS) $(UBLIO_CFLAGS)
