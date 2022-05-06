#.rst:
# FindZLIB
# --------
#
# Find zlib
#
# Find the native ZLIB includes and library.  Once done this will define
#
# ::
#
#   ZLIB_INCLUDE_DIRS   - where to find zlib.h, etc.
#   ZLIB_LIBRARIES      - List of libraries when using zlib.
#   ZLIB_FOUND          - True if zlib found.
#
#
#
# ::
#
#   ZLIB_VERSION_STRING - The version of zlib found (x.y.z)
#   ZLIB_VERSION_MAJOR  - The major version of zlib
#   ZLIB_VERSION_MINOR  - The minor version of zlib
#   ZLIB_VERSION_PATCH  - The patch version of zlib
#   ZLIB_VERSION_TWEAK  - The tweak version of zlib
#
#
#
# The following variable are provided for backward compatibility
#
# ::
#
#   ZLIB_MAJOR_VERSION  - The major version of zlib
#   ZLIB_MINOR_VERSION  - The minor version of zlib
#   ZLIB_PATCH_VERSION  - The patch version of zlib
#
#
#
# An includer may set ZLIB_ROOT to a zlib installation root to tell this
# module where to look.

#=============================================================================
# Copyright 2001-2011 Kitware, Inc.
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

if(HUNTER_STATUS_DEBUG)
  message("[hunter] Custom FindZLIB module")
endif()

find_package(ZLIB CONFIG REQUIRED)
set(ZLIB_LIBRARY ZLIB::zlib)
set(ZLIB_INCLUDE_DIR "${ZLIB_ROOT}/include")

mark_as_advanced(ZLIB_LIBRARY ZLIB_INCLUDE_DIR)

if(ZLIB_INCLUDE_DIR AND EXISTS "${ZLIB_INCLUDE_DIR}/zlib.h")
    file(STRINGS "${ZLIB_INCLUDE_DIR}/zlib.h" ZLIB_H REGEX "^#define ZLIB_VERSION \"[^\"]*\"$")

    string(REGEX REPLACE "^.*ZLIB_VERSION \"([0-9]+).*$" "\\1" ZLIB_VERSION_MAJOR "${ZLIB_H}")
    string(REGEX REPLACE "^.*ZLIB_VERSION \"[0-9]+\\.([0-9]+).*$" "\\1" ZLIB_VERSION_MINOR  "${ZLIB_H}")
    string(REGEX REPLACE "^.*ZLIB_VERSION \"[0-9]+\\.[0-9]+\\.([0-9]+).*$" "\\1" ZLIB_VERSION_PATCH "${ZLIB_H}")
    set(ZLIB_VERSION_STRING "${ZLIB_VERSION_MAJOR}.${ZLIB_VERSION_MINOR}.${ZLIB_VERSION_PATCH}")

    # only append a TWEAK version if it exists:
    set(ZLIB_VERSION_TWEAK "")
    if( "${ZLIB_H}" MATCHES "^.*ZLIB_VERSION \"[0-9]+\\.[0-9]+\\.[0-9]+\\.([0-9]+).*$")
        set(ZLIB_VERSION_TWEAK "${CMAKE_MATCH_1}")
        set(ZLIB_VERSION_STRING "${ZLIB_VERSION_STRING}.${ZLIB_VERSION_TWEAK}")
    endif()

    set(ZLIB_MAJOR_VERSION "${ZLIB_VERSION_MAJOR}")
    set(ZLIB_MINOR_VERSION "${ZLIB_VERSION_MINOR}")
    set(ZLIB_PATCH_VERSION "${ZLIB_VERSION_PATCH}")
endif()

# handle the QUIETLY and REQUIRED arguments and set ZLIB_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ZLIB REQUIRED_VARS ZLIB_LIBRARY ZLIB_INCLUDE_DIR
                                       VERSION_VAR ZLIB_VERSION_STRING)

if(ZLIB_FOUND)
    set(ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR})
    set(ZLIB_LIBRARIES ${ZLIB_LIBRARY})
endif()
