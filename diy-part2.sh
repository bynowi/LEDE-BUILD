#!/bin/bash
# =================================================================
# OpenWrt DIY script part 2 (After Update feeds)
# =================================================================

# 1. 修改后台默认管理 IP 为 192.168.2.1
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认主机名为 LEDE-X86
sed -i 's/OpenWrt/LEDE-X86/g' package/base-files/files/bin/config_generate

# 3. 设置默认时区为东八区
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 4. 拉取 OpenClash（Lean 官方源唯一不含的插件）
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth 1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# 5. 固件构建描述信息自定义
sed -i "s/DISTRIB_DESCRIPTION='.*'/DISTRIB_DESCRIPTION='LEDE Built by GitHub Actions ($(date +%Y.%m.%d))'/g" package/lean/default-settings/files/zzz-default-settings
