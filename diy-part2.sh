#!/bin/bash
# =================================================================
# OpenWrt DIY script part 2 (After Update feeds)
# =================================================================

# 1. 基础网络与后台配置
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/LEDE-X86/g' package/base-files/files/bin/config_generate
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 2. 彻底清除冲突包（核心避坑）
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf package/feeds/luci/luci-theme-argon
rm -rf package/feeds/luci/luci-app-argon-config

# 3. 升级 Golang 编译环境（OpenClash/MosDNS 编译必需）
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

# 4. 精准拉取所需的第三方插件（存入 package/ 独立目录）
# (1) Argon 主题
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# (2) OpenClash
git clone --depth 1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# (3) MosDNS
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns.git package/mosdns
git clone --depth 1 https://github.com/sbwml/v2ray-geodata.git package/v2ray-geodata

# (4) AdGuard Home
git clone --depth 1 https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome

# (5) DDNS-GO
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go

# (6) UA2F
git clone --depth 1 https://github.com/Zxilly/UA2F.git package/UA2F
git clone --depth 1 https://github.com/EOYOHOO/UA2F_LuCI.git package/luci-app-ua2f

# 5. 固件版本描述
sed -i "s/DISTRIB_DESCRIPTION='.*'/DISTRIB_DESCRIPTION='LEDE Built by GitHub Actions ($(date +%Y.%m.%d))'/g" package/lean/default-settings/files/zzz-default-settings
