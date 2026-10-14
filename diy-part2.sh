#!/bin/bash
# =================================================================
# OpenWrt DIY script part 2 (After Update feeds)
# =================================================================

# ----------------- 1. 后台与网络基础参数修改 -----------------
# 修改后台默认管理 IP 为 192.168.2.1（避开光猫常见的 192.168.1.1 冲突）
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名为 LEDE-X86
sed -i 's/OpenWrt/LEDE-X86/g' package/base-files/files/bin/config_generate

# 设置默认时区为东八区
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate


# ----------------- 2. 避免插件命名冲突（核心避坑） -----------------
# 移除可能重复的内置包，优先使用第三方优质仓库
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata


# ----------------- 3. 独立克隆核心第三方插件 -----------------
# (1) 最新版 Argon 主题及其配套背景配置插件
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# (2) OpenClash（官方 Dev 分支，兼容性最好）
git clone --depth 1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# (3) AdGuard Home
git clone --depth 1 https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome

# (4) DDNS-GO 动态域名解析
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go

# (5) UA2F（防校园网/运营商多设备共享检测）
git clone --depth 1 https://github.com/Zxilly/UA2F.git package/UA2F
git clone --depth 1 https://github.com/EOYOHOO/UA2F_LuCI.git package/luci-app-ua2f


# ----------------- 4. 修复 Golang 依赖版本（重要） -----------------
# 第三方 Go 语言开发的程序（如 OpenClash/MosDNS）需要较新版本的 Golang 编译环境
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang


# ----------------- 5. 固件构建信息自定义 -----------------
# 在系统概览页面显示编译者和日期
sed -i "s/DISTRIB_DESCRIPTION='.*'/DISTRIB_DESCRIPTION='LEDE Built by GitHub Actions ($(date +%Y.%m.%d))'/g" package/lean/default-settings/files/zzz-default-settings
