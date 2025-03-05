#!/bin/bash

# ���û�������
ISITE_VERSION="v0.1.3"
ZOLA_VERSION="v0.19.2"
USER="$1"
REPO="$2"
BASE_URL="$3"

# ���ز���װ isite
echo "Downloading and installing isite..."
gh release download $ISITE_VERSION --repo kemingy/isite -p '*Linux_x86_64*' --output isite.tar.gz
tar zxf isite.tar.gz && mv isite /usr/local/bin

# ���� Markdown �ļ�
echo "Generating markdown..."
isite generate --user $USER --repo $REPO

# ���ز���װ zola
echo "Downloading and installing zola..."
gh release download $ZOLA_VERSION --repo getzola/zola -p '*linux*' --output zola.tar.gz
tar zxf zola.tar.gz && mv zola /usr/local/bin

# ����վ��
echo "Building site..."
cp config.toml output/config.toml
cd output && zola build --base-url $BASE_URL

echo "Build completed!"