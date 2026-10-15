#!/bin/bash
# =================================================================
# OpenWrt DIY script part 2 (After Update feeds)
# =================================================================

# 1. 修改后台默认管理 IP 为 192.168.2.1
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 2. 彻底修改默认主机名为 MIHOME（同时修改底层配置与 Lean 初始化覆盖脚本）
sed -i 's/OpenWrt/MIHOME/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/MIHOME/g' package/base-files/files/bin/config_generate
sed -i 's/hostname=LEDE/hostname=MIHOME/g' package/lean/default-settings/files/zzz-default-settings

# 3. 设置默认时区为东八区
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 4. 拉取 OpenClash（只提取核心 luci-app-openclash 目录，避免顶层 Makefile 缺失警告）
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/luci-app-openclash
git clone --depth 1 -b master https://github.com/vernesong/OpenClash.git /tmp/OpenClash
mv /tmp/OpenClash/luci-app-openclash package/luci-app-openclash
rm -rf /tmp/OpenClash

# 5. 固件构建描述信息自定义
sed -i "s/DISTRIB_DESCRIPTION='.*'/DISTRIB_DESCRIPTION='MIHOME Built by GitHub Actions ($(date +%Y.%m.%d))'/g" package/lean/default-settings/files/zzz-default-settings
