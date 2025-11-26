#!/bin/bash
set -euo pipefail

# RLENV Build Script
# This script rebuilds the application from source located at /rlenv/source/exfat/
#
# Original image: ghcr.io/mayhemheroes/exfat:master
# Git revision: dbdce42081dbc5f94a9c0b75d01a5b2841a5a081

# ============================================================================
# Environment Variables
# ============================================================================
# No special environment variables needed for this C project

# ============================================================================
# REQUIRED: Change to Source Directory
# ============================================================================
cd /rlenv/source/exfat/

# ============================================================================
# Clean Previous Build
# ============================================================================
make distclean 2>/dev/null || true
rm -f /fuzz_exfat_debug 2>/dev/null || true
rm -rf /install 2>/dev/null || true

# ============================================================================
# Build Commands (NO NETWORK, NO PACKAGE INSTALLATION)
# ============================================================================
# Configure and build the exfat library
autoreconf -if
./configure --prefix=/install
make -j1
make install

# Build the fuzzer binary with sanitizers (build in current dir, then copy)
clang++ /rlenv/source/exfat/mayhem/fuzz_exfat_debug.cpp \
    -fsanitize=fuzzer,address \
    /rlenv/source/exfat/libexfat/libexfat.a \
    -o /rlenv/source/exfat/fuzz_exfat_debug.tmp

# ============================================================================
# Copy Artifacts (use 'cat >' for busybox compatibility)
# ============================================================================
cat /rlenv/source/exfat/fuzz_exfat_debug.tmp > /fuzz_exfat_debug
rm -f /rlenv/source/exfat/fuzz_exfat_debug.tmp

# ============================================================================
# Set Permissions
# ============================================================================
chmod 777 /fuzz_exfat_debug 2>/dev/null || true

# ============================================================================
# REQUIRED: Verify Build Succeeded
# ============================================================================
if [ ! -f /fuzz_exfat_debug ]; then
    echo "Error: Build artifact not found at /fuzz_exfat_debug"
    exit 1
fi

if [ ! -x /fuzz_exfat_debug ]; then
    echo "Warning: Build artifact is not executable"
fi

SIZE=$(stat -c%s /fuzz_exfat_debug 2>/dev/null || stat -f%z /fuzz_exfat_debug 2>/dev/null || echo 0)
if [ "$SIZE" -lt 1000 ]; then
    echo "Warning: Build artifact is suspiciously small ($SIZE bytes)"
fi

echo "Build completed successfully: /fuzz_exfat_debug"
