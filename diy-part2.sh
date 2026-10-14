#!/bin/bash
# =================================================================
# OpenWrt DIY script part 2 (After Update feeds)
# =================================================================

# 1. 修改后台默认管理 IP 为 192.168.2.1（避开光猫常见的 192.168.1.1 冲突）
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认主机名为 LEDE-X86
sed -i 's/OpenWrt/LEDE-X86/g' package/base-files/files/bin/config_generate

# 3. 设置默认时区为东八区
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 4. 避免插件命名冲突（清理旧包，优先使用外部最新版）
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata

# 5. 独立拉取核心第三方插件
# (1) 最新版 Argon 主题及其配套背景配置插件
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# (2) OpenClash（官方 Dev 分支）
git clone --depth 1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# (3) AdGuard Home
git clone --depth 1 https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome

# (4) DDNS-GO 动态域名解析
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go

# (5) UA2F（防校园网/运营商多设备共享检测）
git clone --depth 1 https://github.com/Zxilly/UA2F.git package/UA2F
git clone --depth 1 https://github.com/EOYOHOO/UA2F_LuCI.git package/luci-app-ua2f

# 6. 修复/升级 Golang 依赖版本至 24.x（满足 OpenClash/MosDNS 编译要求）
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

# 7. 固件构建描述信息自定义
sed -i "s/DISTRIB_DESCRIPTION='.*'/DISTRIB_DESCRIPTION='LEDE Built by GitHub Actions ($(date +%Y.%m.%d))'/g" package/lean/default-settings/files/zzz-default-settings
