################################################################################
#
# kf5-extra-cmake-modules
#
################################################################################

BB_KF5_EXTRA_CMAKE_MODULES_VERSION = $(KF5_VERSION)
BB_KF5_EXTRA_CMAKE_MODULES_SITE = $(KF5_SITE)
BB_KF5_EXTRA_CMAKE_MODULES_SOURCE = extra-cmake-modules-$(BB_KF5_EXTRA_CMAKE_MODULES_VERSION).tar.xz
BB_KF5_EXTRA_CMAKE_MODULES_LICENSE = BSD-3-Clause
BB_KF5_EXTRA_CMAKE_MODULES_LICENSE_FILES = COPYING-CMAKE-SCRIPTS

BB_KF5_EXTRA_CMAKE_MODULES_DEPENDENCIES = host-pkgconf
BB_KF5_EXTRA_CMAKE_MODULES_INSTALL_STAGING = YES
BB_KF5_EXTRA_CMAKE_MODULES_INSTALL_TARGET = NO

$(eval $(cmake-package))
