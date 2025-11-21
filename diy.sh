#!/bin/bash
# ============================================
# diy.sh - SL-3000 固件定制脚本 (Docker版)
# ============================================

# 1. 修改默认 IP (改为 192.168.6.1)
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认主题为 argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 3. 添加 passwall2 源
echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git" >> feeds.conf.default

# 4. Docker 支持 (在 .config 中启用 docker/dockerd/luci-app-docker 即可)

# 5. 更新 feeds 并安装
./scripts/feeds update -a
./scripts/feeds install -a

# 6. 删除不必要的包 (精简固件体积)
rm -rf feeds/luci/themes/luci-theme-bootstrap
rm -rf feeds/packages/net/samba4

# 7. 拉取额外插件 (argon-config)
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 8. 打印提示
echo "============================================"
echo "diy.sh 已执行完成："
echo "- 默认 IP 修改为 192.168.6.1"
echo "- 默认主题修改为 argon"
echo "- 添加 passwall2 源"
echo "- 启用 Docker 支持 (需在 .config 勾选)"
echo "- 精简不必要的包"
echo "============================================"
