#!/bin/bash
set -e

apt update && apt install -y zip unzip

git clone https://github.com/criteo-forks/marathon-ui.git -b criteo /opt/marathon-ui

cd /opt/marathon-ui && mkdir -p /build/dist

echo "Build marathon-ui"
/usr/local/bin/npm install && \
/usr/local/bin/npm install -g gulp && \
/usr/local/bin/npm run dist

mkdir /tmp/marathon-ui && cd /tmp/marathon-ui
unzip /build/mesosphere.marathon.ui-template.jar -d .
cp -r /opt/marathon-ui/dist/* ./META-INF/resources/webjars/ui/
cp /build/runtimeConfig.template.js ./META-INF/resources/webjars/ui/
zip -r /build/dist/mesosphere.marathon.ui-1.2.0.jar META-INF
