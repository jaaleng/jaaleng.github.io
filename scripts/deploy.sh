#!/bin/bash

# 设置环境变量
ISITE_VERSION="v0.1.3"
ZOLA_VERSION="v0.19.2"
USER="$1"
REPO="$2"
BASE_URL="$3"

# 下载并安装 isite
echo "Downloading and installing isite..."
gh release download $ISITE_VERSION --repo kemingy/isite -p '*Linux_x86_64*' --output isite.tar.gz
tar zxf isite.tar.gz && mv isite /usr/local/bin

# 生成 Markdown 文件
echo "Generating markdown..."
isite generate --user $USER --repo $REPO

# 下载并安装 zola
echo "Downloading and installing zola..."
gh release download $ZOLA_VERSION --repo getzola/zola -p '*linux*' --output zola.tar.gz
tar zxf zola.tar.gz && mv zola /usr/local/bin

# 构建站点
echo "Building site..."
cp config.toml output/config.toml
cd output && zola build --base-url $BASE_URL

echo "Build completed!"
```

---

### 2. **更新 GitHub Actions 工作流**
在 GitHub Actions 工作流中调用该脚本，并传递必要的参数。

#### `.github/workflows/deploy.yml`
```yaml
name: Deploy static content to Pages

on:
  issues:
    types:
      - opened
      - edited
      - closed
      - reopened
      - labeled
      - unlabeled
  workflow_dispatch:

# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: ${{ github.workflow }}
  cancel-in-progress: true

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    env:
      GH_TOKEN: ${{ github.token }}
      USER: ${{ github.repository_owner }}
      REPO: ${{ github.event.repository.name }}
      BASE_URL: ${{ secrets.BASE_URL || 'https://jianghaiyina.com' }} # 使用 Secrets 或默认值
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: |
            /usr/local/bin/isite
            /usr/local/bin/zola
          key: ${{ runner.os }}-deps-${{ hashFiles('**/config.toml') }}
          restore-keys: |
            ${{ runner.os }}-deps-

      - name: Make script executable
        run: chmod +x ./scripts/deploy.sh

      - name: Run deploy script
        run: ./scripts/deploy.sh "$USER" "$REPO" "$BASE_URL"

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          name: pages-artifact
          path: 'output/public'

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
        with:
          artifact_name: pages-artifact
