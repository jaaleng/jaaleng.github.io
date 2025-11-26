# [利用新Repository给Github Pages配置多个域名](https://github.com/jaaleng/jaaleng.github.io/issues/267)

一个Github Pages只能绑定一个自定义域名，但在已经绑定了一个域名的情况下，想使用多个域名访问到托管到Github Pages的页面时该怎么办呢？

我们可以通过设置另外一个新的Github Pages来绑定新的域名，再通过新的Github Pages来重定向到指定的Github Pages。下面介绍方法步骤。

### 第一步：设置主仓库

假设你的主仓库名为 `my-awesome-site`，并且你已经搭建好了 GitHub Pages。

1.  在仓库根目录下创建一个 `CNAME` 文件，里面只包含你的主域名，例如：
    ```
    www.domain1.com
    ```
2.  前往仓库 Settings -> Pages -> Custom domain，填写 `www.domain1.com` 并保存。

3.  在你的域名注册商（如 GoDaddy, Cloudflare, Namecheap 等）那里，为 `www.domain1.com` 配置 `CNAME` 记录，指向 `<你的github用户名>.github.io`。
现在，`www.domain1.com` 应该可以正常访问你的站点了。

#### 第二步：创建并设置代理仓库

现在我们来处理第二个域名 `www.domain2.com`。

1.  **创建新仓库**：
    创建一个全新的 GitHub 仓库，名字可以叫 `domain2-proxy` 或任何你喜欢的名字。

2.  **启用 GitHub Pages**：
    进入这个新仓库的 Settings -> Pages -> Source，选择“Deploy from a branch”，然后选择一个分支（通常用 `main` 分支的 `/root` 目录）。

3.  **创建代理文件**：
    在新仓库中，创建一个 `index.html` 文件。这个文件是整个方案的核心。


```<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loading Site...</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px;
        }
        
        .container {
            max-width: 600px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        p {
            font-size: 1.2rem;
            line-height: 1.6;
            margin-bottom: 25px;
            opacity: 0.9;
        }
        
        .loader {
            width: 60px;
            height: 60px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            margin: 20px auto;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .btn {
            display: inline-block;
            background: white;
            color: #2575fc;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            margin-top: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }
        
        .info-box {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            text-align: left;
        }
        
        .info-box h3 {
            margin-bottom: 10px;
            font-size: 1.2rem;
        }
        
        .info-box ul {
            list-style-type: none;
            padding-left: 10px;
        }
        
        .info-box li {
            margin-bottom: 8px;
            position: relative;
            padding-left: 20px;
        }
        
        .info-box li:before {
            content: "•";
            position: absolute;
            left: 0;
            color: #6a11cb;
            font-weight: bold;
        }
        
        .status {
            margin-top: 20px;
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        .domain {
            font-weight: bold;
            color: #ffcc00;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Loading Content</h1>
        <p>We're fetching content from the primary site. Please wait...</p>
        
        <div class="loader"></div>
        
        <p class="status">Connecting to: <span class="domain" id="target-domain">https://yourusername.github.io/my-awesome-site</span></p>
        
        <a href="#" class="btn" id="manual-redirect">Click here if not redirected</a>
        
        <div class="info-box">
            <h3>How this works:</h3>
            <ul>
                <li>This page acts as a proxy for your main GitHub Pages site</li>
                <li>Content is loaded from your primary repository</li>
                <li>All links are rewritten to maintain the current domain</li>
                <li>This allows multiple domains to serve the same content</li>
            </ul>
        </div>
    </div>

    <script>
        // Configuration - Update these values for your setup
        const CONFIG = {
            primarySiteUrl: 'https://yourusername.github.io/my-awesome-site', // Your main GitHub Pages URL
            proxyDomain: 'https://www.domain2.com', // The domain of this proxy page
            enableLinkRewriting: true, // Set to false to disable link rewriting
            fallbackRedirect: true // Set to false to disable automatic redirect on error
        };
        
        // Update displayed domain
        document.getElementById('target-domain').textContent = CONFIG.primarySiteUrl;
        
        // Manual redirect button
        document.getElementById('manual-redirect').addEventListener('click', function(e) {
            e.preventDefault();
            window.location.replace(CONFIG.primarySiteUrl + window.location.pathname);
        });
        
        // Main proxy function
        (async function() {
            try {
                const targetUrl = CONFIG.primarySiteUrl + window.location.pathname + window.location.search;
                
                console.log('Fetching content from:', targetUrl);
                
                const response = await fetch(targetUrl);
                
                if (response.ok) {
                    const html = await response.text();
                    
                    // Parse the HTML
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(html, 'text/html');
                    
                    // Rewrite links if enabled
                    if (CONFIG.enableLinkRewriting) {
                        rewriteLinks(doc, CONFIG.primarySiteUrl, CONFIG.proxyDomain);
                    }
                    
                    // Replace the current document
                    document.open();
                    document.write(doc.documentElement.outerHTML);
                    document.close();
                    
                    console.log('Content loaded successfully with link rewriting');
                    
                } else {
                    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                }
                
            } catch (error) {
                console.error('Proxy failed:', error);
                
                // Fallback to redirect
                if (CONFIG.fallbackRedirect) {
                    console.log('Falling back to redirect');
                    window.location.replace(CONFIG.primarySiteUrl + window.location.pathname);
                } else {
                    // Show error message
                    document.querySelector('.container').innerHTML = `
                        <h1>Connection Error</h1>
                        <p>We couldn't load content from the primary sit```



## 使用说明

1. **配置部分**：在代码开头的CONFIG对象中，更新以下值：
   - `primarySiteUrl`: 你的主GitHub Pages仓库URL
   - `proxyDomain`: 这个代理页面使用的域名

2. **部署**：
   - 将这段代码保存为`index.html`
   - 上传到一个新的GitHub仓库
   - 在该仓库的Settings中启用GitHub Pages
   - 添加你的第二个域名到该仓库的CNAME文件

3. **功能特点**：
   - 美观的加载界面
   - 自动内容获取和链接重写
   - 手动重定向按钮作为备用
   - 错误处理和用户友好的错误消息
   - 响应式设计，适配各种设备

这个页面会无缝地从你的主GitHub Pages站点获取内容，同时保持用户在代理域效果。

这是个简化脚本。
```<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Redirecting...</title>
    <meta http-equiv="refresh" content="0; url=https://meektion.github.io">
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .loader {
            border: 5px solid #f3f3f3;
            border-top: 5px solid #3498db;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 2s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <h1>Redirecting to meektion.github.io</h1>
    <div class="loader"></div>
    <p>If you are not redirected automatically, <a href="https://meektion.github.io" style="color: #ffeb3b;">click here</a>.</p>
    
    <script>
        // 立即重定向
        window.location.replace('https://meektion.github.io' + window.location.pathname + window.location.search);
    </script>
</body>
</html>```




## 简化方案的优点

现在的方案虽然第一次稍慢，但有以下优势：
保持URL不变（用户停留在你的自定义域名） 完整的链接重写功能
 更好的SEO表现（相比简单重定向）
 用户体验更连贯

第一次的加载延迟是正常的，后续访问就会很快了！如果你对当前性能满意，就不需要做任何改动。

其中的网址改成你自己的网站网址。




