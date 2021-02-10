################################################################################
#
# ti-sgx-km
#
################################################################################

# This correpsonds to SDK 06.00.00.07
BB_TI_SGX_KM_VERSION = bfe83bbabb3849c24b03d5172cf678e7c5915e04
BB_TI_SGX_KM_SITE = http://git.ti.com/git/graphics/omap5-sgx-ddk-linux.git
BB_TI_SGX_KM_SITE_METHOD = git
BB_TI_SGX_KM_LICENSE = GPL-2.0
BB_TI_SGX_KM_LICENSE_FILES = eurasia_km/GPL-COPYING

BB_TI_SGX_KM_DEPENDENCIES = linux

BB_TI_SGX_KM_MAKE_OPTS = \
	$(LINUX_MAKE_FLAGS) \
	KERNELDIR=$(LINUX_DIR) \
	TARGET_PRODUCT=$(BB_TI_SGX_KM_PLATFORM_NAME)

BB_TI_SGX_KM_PLATFORM_NAME = ti335x

BB_TI_SGX_KM_SUBDIR = eurasia_km/eurasiacon/build/linux2/omap_linux

define BB_TI_SGX_KM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(BB_TI_SGX_KM_MAKE_OPTS) \
		-C $(@D)/$(BB_TI_SGX_KM_SUBDIR)
endef

define BB_TI_SGX_KM_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(BB_TI_SGX_KM_MAKE_OPTS) \
		DISCIMAGE=$(TARGET_DIR) \
		kbuild_install -C $(@D)/$(BB_TI_SGX_KM_SUBDIR)
endef

$(eval $(generic-package))
