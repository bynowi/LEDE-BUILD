#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1. 修改默认后台 IP（默认是 192.168.1.1，可改成 192.168.2.1 或 192.168.6.1 避免光猫冲突）
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 2. 修改设备默认主机名（默认是 OpenWrt）
# sed -i 's/OpenWrt/LEDE-Router/g' package/base-files/files/bin/config_generate

# 3. 设置默认 Argon 主题为首选界面（需确保配置中勾选了 luci-theme-argon）
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 4. 修复/克隆单独的第三方插件（直接下载到 package/ 目录）
# 示例：拉取最新版 luci-theme-argon
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/downloads/luci-theme-argon

# 示例：拉取 MosDNS 插件
# git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns

# 5. 修改版本号标识（在后台管理界面的版本信息中加入编译作者）
# sed -i "s/DISTRIB_DESCRIPTION='.*'/DISTRIB_DESCRIPTION='LEDE Built by YourName ($(date +%Y.%m.%d))'/g" package/lean/default-settings/files/zzz-default-settings
