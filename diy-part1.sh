#!/bin/bash
# =================================================================
# OpenWrt DIY script part 1 (Before Update feeds)
# =================================================================

# 1. 开启 helloworld 源
sed -i 's/^#src-git helloworld/src-git helloworld/g' feeds.conf.default

# 2. 添加常用的大全第三方软件源（包含 OpenClash/MosDNS 依赖包）
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 3. 添加 MosDNS 专有源
echo 'src-git mosdns https://github.com/sbwml/luci-app-mosdns' >> feeds.conf.default
