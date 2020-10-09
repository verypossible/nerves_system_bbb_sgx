################################################################################
#
# ti-sgx-um
#
################################################################################

# This correpsonds to SDK 06.00.00.07 plus one pull request
BB_TI_SGX_UM_VERSION = 2a2e5bb090ced870d73ed4edbc54793e952cc6d8
BB_TI_SGX_UM_SITE = http://git.ti.com/git/graphics/omap5-sgx-ddk-um-linux.git
BB_TI_SGX_UM_SITE_METHOD = git
BB_TI_SGX_UM_LICENSE = TI TSPA License
BB_TI_SGX_UM_LICENSE_FILES = TI-Linux-Graphics-DDK-UM-Manifest.doc
BB_TI_SGX_UM_INSTALL_STAGING = YES
BB_TI_SGX_UM_TARGET=ti335x

# ti-sgx-um is a egl/gles provider only if libdrm is installed
BB_TI_SGX_UM_DEPENDENCIES = libdrm wayland

define BB_TI_SGX_UM_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DISCIMAGE=$(STAGING_DIR) \
		TARGET_PRODUCT=$(BB_TI_SGX_UM_TARGET) install
endef

define BB_TI_SGX_UM_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DISCIMAGE=$(TARGET_DIR) \
		TARGET_PRODUCT=$(BB_TI_SGX_UM_TARGET) install
endef

BB_TI_SGX_UM_POST_INSTALL_TARGET_HOOKS += BB_TI_SGX_UM_INSTALL_CONF

$(eval $(generic-package))
