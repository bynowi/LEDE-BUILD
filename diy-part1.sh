#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 1. 解开 feeds.conf.default 中的 helloworld 源（如果需要）
# sed -i 's/^#src-git helloworld/src-git helloworld/g' feeds.conf.default

# 2. 添加第三方软件源（按需取消注释）
# 示例：添加 passwall 源
# echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' >> feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main' >> feeds.conf.default

# 示例：添加 openwrt-packages 源
# echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
