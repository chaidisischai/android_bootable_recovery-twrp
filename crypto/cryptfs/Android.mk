LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
ifeq ($(TW_INCLUDE_CRYPTO), true)
LOCAL_SRC_FILES:= \
	cryptfs.c

LOCAL_CFLAGS:= -g -c -W -I../fs_mgr/include
LOCAL_CFLAGS += -DTW_INCLUDE_CRYPTO
LOCAL_CFLAGS += -DCRYPTO_FS_TYPE=\"$(TW_CRYPTO_FS_TYPE)\"
LOCAL_CFLAGS += -DCRYPTO_REAL_BLKDEV=\"$(TW_CRYPTO_REAL_BLKDEV)\"
LOCAL_CFLAGS += -DCRYPTO_MNT_POINT=\"$(TW_CRYPTO_MNT_POINT)\"
LOCAL_CFLAGS += -DCRYPTO_FS_OPTIONS=\"$(TW_CRYPTO_FS_OPTIONS)\"
LOCAL_CFLAGS += -DCRYPTO_FS_FLAGS=\"$(TW_CRYPTO_FS_FLAGS)\"
LOCAL_CFLAGS += -DCRYPTO_KEY_LOC=\"$(TW_CRYPTO_KEY_LOC)\"
ifdef TW_CRYPTO_SD_REAL_BLKDEV
    LOCAL_CFLAGS += -DCRYPTO_SD_REAL_BLKDEV=\"$(TW_CRYPTO_SD_REAL_BLKDEV)\"
    LOCAL_CFLAGS += -DCRYPTO_SD_FS_TYPE=\"$(TW_CRYPTO_SD_FS_TYPE)\"
endif
ifneq ($(TW_INTERNAL_STORAGE_PATH),)
	LOCAL_CFLAGS += -DTW_INTERNAL_STORAGE_PATH=$(TW_INTERNAL_STORAGE_PATH)
endif
ifneq ($(TW_INTERNAL_STORAGE_MOUNT_POINT),)
	LOCAL_CFLAGS += -DTW_INTERNAL_STORAGE_MOUNT_POINT=$(TW_INTERNAL_STORAGE_MOUNT_POINT)
endif
ifneq ($(TW_EXTERNAL_STORAGE_PATH),)
	LOCAL_CFLAGS += -DTW_EXTERNAL_STORAGE_PATH=$(TW_EXTERNAL_STORAGE_PATH)
endif
ifneq ($(TW_EXTERNAL_STORAGE_MOUNT_POINT),)
	LOCAL_CFLAGS += -DTW_EXTERNAL_STORAGE_MOUNT_POINT=$(TW_EXTERNAL_STORAGE_MOUNT_POINT)
endif

LOCAL_C_INCLUDES += system/extras/ext4_utils external/openssl/include
LOCAL_MODULE:=cryptfs
LOCAL_MODULE_TAGS:= eng
LOCAL_SHARED_LIBRARIES += libc libcutils
LOCAL_SHARED_LIBRARIES += libcrypto


#LOCAL_LDFLAGS += -L$(TARGET_OUT_SHARED_LIBRARIES) -lsec_km -lsec_ecryptfs -ldl
LOCAL_LDFLAGS += -ldl

LOCAL_STATIC_LIBRARIES += libmtdutils
LOCAL_STATIC_LIBRARIES += libminadbd libminzip libunz
LOCAL_STATIC_LIBRARIES += libminuitwrp libpixelflinger_static libpng libjpegtwrp libgui
LOCAL_SHARED_LIBRARIES += libz libc libstlport libcutils libstdc++ libmincrypt libext4_utils
LOCAL_STATIC_LIBRARIES += libcrypt_samsung

#libpixelflinger_static for x86 is using encoder under hardware/intel/apache-harmony
ifeq ($(TARGET_ARCH),x86)
LOCAL_STATIC_LIBRARIES += libenc
endif

LOCAL_STATIC_LIBRARIES += $(TARGET_RECOVERY_UI_LIB)
#LOCAL_STATIC_LIBRARIES += libfs_mgrtwrp
LOCAL_MODULE_CLASS := UTILITY_EXECUTABLES
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/utilities
include $(BUILD_EXECUTABLE)

endif