# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.18 = .43
LINUX_VERSION-4.1 = .34
LINUX_VERSION-4.4 = .36
LINUX_VERSION-4.8 = .12

LINUX_KERNEL_MD5SUM-3.18.43 = b1faeb4a2e1e70ffe061bdbb3452840a
LINUX_KERNEL_MD5SUM-4.1.34 = fba99f0f4765ebf01033e69518740a3c
LINUX_KERNEL_MD5SUM-4.4.36 = c23de77131c05a27e638026972ada85b
LINUX_KERNEL_MD5SUM-4.8.12 = 847486f77747b6f99c527b68b3ffe79686afe68e6c04e1dbc8b153acccc0250e

ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_MD5SUM:=$(LINUX_KERNEL_MD5SUM-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_MD5SUM?=x
