#!/bin/bash
set -e

cd /workdir/openwrt

echo "==> 保持默认 LAN IP 为 192.168.1.1"

echo "==> 修改默认主机名为 OpenWrt-R66S"
if [ -f package/base-files/files/bin/config_generate ]; then
  sed -i "s/hostname='OpenWrt'/hostname='OpenWrt-R66S'/g" package/base-files/files/bin/config_generate
fi

echo "==> 设置默认时区为 Asia/Shanghai"
if [ -f package/base-files/files/bin/config_generate ]; then
  sed -i "s#timezone='UTC'#timezone='CST-8'#g" package/base-files/files/bin/config_generate || true
  sed -i "s#zonename='UTC'#zonename='Asia/Shanghai'#g" package/base-files/files/bin/config_generate || true
fi

echo "==> 设置默认 NTP 服务器"
if [ -f package/base-files/files/bin/config_generate ]; then
  sed -i "/set system.ntp.server=/,/commit system/{
    s/'0.openwrt.pool.ntp.org'/'ntp.aliyun.com'/g
    s/'1.openwrt.pool.ntp.org'/'cn.pool.ntp.org'/g
    s/'2.openwrt.pool.ntp.org'/'time1.cloud.tencent.com'/g
    s/'3.openwrt.pool.ntp.org'/'time.ustc.edu.cn'/g
  }" package/base-files/files/bin/config_generate || true
fi

echo "init-settings executed successfully!"
