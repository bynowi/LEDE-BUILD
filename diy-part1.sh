#!/bin/bash
# =================================================================
# OpenWrt DIY script part 1 (Before Update feeds)
# =================================================================

# 解除 helloworld 默认注释（如果需要）
sed -i 's/^#src-git helloworld/src-git helloworld/g' feeds.conf.default

# 注意：不要在此处引入 kenzo 和 small，会导致极其严重的包冲突！
