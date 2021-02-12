################################################################################
#
# bb_kmscube
#
################################################################################

BB_KMSCUBE_VERSION = 7bc7ff6c4ead19761003ed4a08d00ce64effe38b
BB_KMSCUBE_SITE = git://git.ti.com/glsdk/kmscube.git
BB_KMSCUBE_SITE_METHOD = git
BB_KMSCUBE_LICENSE = MIT
BB_KMSCUBE_DEPENDENCIES = libdrm bb-ti-sgx-um

define BB_KMSCUBE_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef

BB_KMSCUBE_PRE_CONFIGURE_HOOKS += BB_KMSCUBE_RUN_AUTOGEN

$(eval $(autotools-package))
