# [axios 维护者账号遭劫持：npm 恶意版本注入远程控制木马](https://github.com/jaaleng/jaaleng.github.io/issues/299)

axios 维护者账号遭劫持：npm 恶意版本注入远程控制木马

![IMG_20260331_134727_134.jpg](https://i.829259.xyz/api/rfile/IMG_20260331_134727_134.jpg)

2026 年 3 月 31 日，安全机构 StepSecurity 发现主流 JavaScript 库 axios 的 npm 维护者账号遭劫持。攻击者绕过正常的 GitHub Actions CI/CD 流程，手动发布了两个恶意版本 axios@1.14.1 和 axios@0.30.4。这些版本通过注入虚假依赖 plain-crypto-js 触发恶意脚本，针对 Windows、macOS 和 Linux 系统植入远程访问木马（RAT），并连接到特定的 C2 服务器进行远程控制。

该恶意软件具备极强的隐蔽性，在执行后会自动删除恶意脚本并伪造 clean 版本的配置文件以规避安全审计。由于 axios 每周下载量超过 3 亿次，此次供应链攻击潜在影响巨大。安全专家建议开发者立即检查项目依赖，若已安装受影响版本，应尽快降级至安全版本（1.14.0 或 0.30.3），并更换受影响机器上的所有密钥与凭据。

StepSecurity
https://www.stepsecurity.io/blog/axios-compromised-on-npm-malicious-versions-drop-remote-access-trojan
