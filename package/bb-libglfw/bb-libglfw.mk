################################################################################
#
# libglfw
#
################################################################################

BB_LIBGLFW_VERSION = 3.3.2
BB_LIBGLFW_SITE = $(call github,glfw,glfw,$(BB_LIBGLFW_VERSION))
BB_LIBGLFW_INSTALL_STAGING = YES
BB_LIBGLFW_DEPENDENCIES = bb-ti-sgx-um bb-weston bb-kf5-extra-cmake-modules
BB_LIBGLFW_LICENSE = Zlib
BB_LIBGLFW_LICENSE_FILES = LICENSE.md

BB_LIBGLFW_CONF_OPTS += \
	-DGLFW_BUILD_EXAMPLES=OFF \
	-DGLFW_BUILD_TESTS=OFF \
	-DGLFW_BUILD_DOCS=OFF \
	-DGLFW_USE_WAYLAND=ON \
	-DGLFW_USE_OSMESA=OFF

ifeq ($(BR2_PACKAGE_XLIB_LIBXXF86VM),y)
BB_LIBGLFW_DEPENDENCIES += xlib_libXxf86vm
endif

$(eval $(cmake-package))
