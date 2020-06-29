################################################################################
#
# weston
#
################################################################################

BB_WESTON_VERSION = 8.0.0
BB_WESTON_SITE = http://wayland.freedesktop.org/releases
BB_WESTON_SOURCE = weston-$(BB_WESTON_VERSION).tar.xz
BB_WESTON_LICENSE = MIT
BB_WESTON_LICENSE_FILES = COPYING

BB_WESTON_DEPENDENCIES = host-pkgconf wayland wayland-protocols \
	libxkbcommon pixman libpng jpeg udev cairo libinput libdrm

BB_WESTON_CONF_OPTS = \
	-Dbackend-headless=false \
	-Dcolor-management-colord=false \
	-Dremoting=false

# Uses VIDIOC_EXPBUF, only available from 3.8+
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_8),y)
BB_WESTON_CONF_OPTS += -Dsimple-clients=dmabuf-v4l
else
BB_WESTON_CONF_OPTS += -Dsimple-clients=
endif

ifeq ($(BR2_PACKAGE_DBUS)$(BR2_PACKAGE_SYSTEMD),yy)
BB_WESTON_CONF_OPTS += -Dlauncher-logind=true
BB_WESTON_DEPENDENCIES += dbus systemd
else
BB_WESTON_CONF_OPTS += -Dlauncher-logind=false
endif

ifeq ($(BR2_PACKAGE_WEBP),y)
BB_WESTON_CONF_OPTS += -Dimage-webp=true
BB_WESTON_DEPENDENCIES += webp
else
BB_WESTON_CONF_OPTS += -Dimage-webp=false
endif

# weston-launch must be u+s root in order to work properly
ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
define BB_WESTON_PERMISSIONS
	/usr/bin/weston-launch f 4755 0 0 - - - - -
endef
define BB_WESTON_USERS
	- - weston-launch -1 - - - - Weston launcher group
endef
BB_WESTON_CONF_OPTS += -Dweston-launch=true
BB_WESTON_DEPENDENCIES += linux-pam
else
BB_WESTON_CONF_OPTS += -Dweston-launch=false
endif

ifeq ($(BR2_PACKAGE_HAS_LIBEGL_WAYLAND)$(BR2_PACKAGE_HAS_LIBGLES),yy)
BB_WESTON_CONF_OPTS += -Drenderer-gl=true
BB_WESTON_DEPENDENCIES += libegl libgles
else
BB_WESTON_CONF_OPTS += \
	-Drenderer-gl=false
endif

ifeq ($(BR2_PACKAGE_BB_WESTON_RDP),y)
BB_WESTON_DEPENDENCIES += freerdp
BB_WESTON_CONF_OPTS += -Dbackend-rdp=true
else
BB_WESTON_CONF_OPTS += -Dbackend-rdp=false
endif

ifeq ($(BR2_PACKAGE_BB_WESTON_FBDEV),y)
BB_WESTON_CONF_OPTS += -Dbackend-fbdev=true
else
BB_WESTON_CONF_OPTS += -Dbackend-fbdev=false
endif

ifeq ($(BR2_PACKAGE_BB_WESTON_DRM),y)
BB_WESTON_CONF_OPTS += -Dbackend-drm=true
else
BB_WESTON_CONF_OPTS += -Dbackend-drm=false
endif

ifeq ($(BR2_PACKAGE_BB_WESTON_X11),y)
BB_WESTON_CONF_OPTS += -Dbackend-x11=true
BB_WESTON_DEPENDENCIES += libxcb xlib_libX11
else
BB_WESTON_CONF_OPTS += -Dbackend-x11=false
endif

# We're guaranteed to have at least one backend
BB_WESTON_CONF_OPTS += -Dbackend-default=$(call qstrip,$(BR2_PACKAGE_BB_WESTON_DEFAULT_COMPOSITOR))

ifeq ($(BR2_PACKAGE_BB_WESTON_XWAYLAND),y)
BB_WESTON_CONF_OPTS += -Dxwayland=true
BB_WESTON_DEPENDENCIES += cairo libepoxy libxcb xlib_libX11 xlib_libXcursor
else
BB_WESTON_CONF_OPTS += -Dxwayland=false
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
BB_WESTON_CONF_OPTS += -Dbackend-drm-screencast-vaapi=true
BB_WESTON_DEPENDENCIES += libva
else
BB_WESTON_CONF_OPTS += -Dbackend-drm-screencast-vaapi=false
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
BB_WESTON_CONF_OPTS += -Dcolor-management-lcms=true
BB_WESTON_DEPENDENCIES += lcms2
else
BB_WESTON_CONF_OPTS += -Dcolor-management-lcms=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
BB_WESTON_CONF_OPTS += -Dsystemd=true
BB_WESTON_DEPENDENCIES += systemd
else
BB_WESTON_CONF_OPTS += -Dsystemd=false
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
BB_WESTON_CONF_OPTS += -Dtest-junit-xml=true
BB_WESTON_DEPENDENCIES += libxml2
else
BB_WESTON_CONF_OPTS += -Dtest-junit-xml=false
endif

ifeq ($(BR2_PACKAGE_PIPEWIRE)$(BR2_PACKAGE_BB_WESTON_DRM),yy)
BB_WESTON_CONF_OPTS += -Dpipewire=true
BB_WESTON_DEPENDENCIES += pipewire
else
BB_WESTON_CONF_OPTS += -Dpipewire=false
endif

ifeq ($(BR2_PACKAGE_BB_WESTON_DEMO_CLIENTS),y)
BB_WESTON_CONF_OPTS += -Ddemo-clients=true
BB_WESTON_DEPENDENCIES += pango
else
BB_WESTON_CONF_OPTS += -Ddemo-clients=false
endif

$(eval $(meson-package))
