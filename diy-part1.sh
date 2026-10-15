#!/bin/bash
# =================================================================
# OpenWrt DIY script part 1 (Before Update feeds)
# =================================================================

# 开启 helloworld 源（如果默认注释了）
sed -i 's/^#src-git helloworld/src-git helloworld/g' feeds.conf.default
