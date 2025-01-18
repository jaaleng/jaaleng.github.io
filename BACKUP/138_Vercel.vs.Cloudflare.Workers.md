# [Vercel vs Cloudflare Workers](https://github.com/jaaleng/jaaleng.github.io/issues/138)

cloudflare是当之无愧的赛博佛祖，刚起步的项目或者访问量不大的项目，部署到CF，根本就是免费的，

![](https://pic.superbed.cc/item/678bbb97fa9f77b4dc64db4d.png)

为什么还要选择vercel呢，就是因为折腾了大半个月得出来的结论，
cloudflare对next.js的支持并不完美，部署的时候往往改到你崩溃，而next.js在部署在vercel里面基本一把过，  

那么，前端要用next.js框架的时候， **vercel前端+cloudflare后端**
是目前一雄实践最完美的组合了，下面通过对比这两家的参数来直观看看这个结论。  

#  Cloudflare vs Vercel：Web部署最佳实践对比指南

##  为什么选择这两个平台？

###  Cloudflare（赛博佛祖）的优势

  * 适合初创项目 
  * 小流量项目基本免费 
  * 全球CDN加速 
  * 安全防护完善 

###  Vercel的必要性

  * Next.js原生支持 
  * 部署便捷，基本一次成功 
  * 前端优化出色 

##  一、免费额度对比

特性  |  Vercel Edge Functions  |  Cloudflare Workers  
---|---|---  
执行时间  |  100GB-小时/月  |  \-  
请求数/调用量  |  100,000次/天  |  100,000次/天  
带宽  |  100GB/月  |  \-  
构建时间  |  100小时/月  |  \-  
并发执行  |  10个  |  \-  
函数超时  |  10秒  |  30秒  
CPU时间  |  \-  |  10ms/请求  
脚本数量  |  无限制  |  30个  
子域名  |  \-  |  1个  
KV存储  |  \-  |  1GB  
  
##  二、付费方案对比

特性  |  Vercel Pro ($20/月)  |  Cloudflare Workers ($5/月)  
---|---|---  
执行时间  |  1000GB-小时/月  |  \-  
请求数  |  无限制  |  1000万次/月  
带宽  |  1TB/月  |  \-  
构建时间  |  400小时/月  |  \-  
并发执行  |  25个  |  \-  
函数超时  |  30秒  |  30秒  
CPU时间  |  \-  |  50ms/请求  
脚本数量  |  无限制  |  无限制  
子域名  |  \-  |  无限制  
  
##  三、深度对比分析

###  1\. 成本效益

✅ Cloudflare：

  * 起价更低($5/月) 
  * 灵活按量计费 
  * 免费版功能丰富 

###  2\. 性能表现

🌟 平台优势对比：

Cloudflare  |  Vercel  
---|---  
更多全球边缘节点  |  Next.js优化加成  
更宽松执行时间限制  |  前端性能优化  
  
###  3\. 适用场景对比

Cloudflare Workers  |  Vercel Edge Functions  
---|---  
🔹 长时间运行任务  |  🔸 Next.js项目开发  
🔹 全球用户分布  |  🔸 前后端一体化部署  
🔹 预算受限团队  |  🔸 完整CI/CD需求  
🔹 精细成本控制  |  🔸 团队协作项目  
  
##  四、选择建议

###  项目规模考量

  * 小型项目：两平台免费额度足够 
  * 大型项目：推荐Cloudflare付费方案 

###  技术栈考量

  * Next.js项目：首选Vercel 
  * 常规Node.js：两者皆可 

###  预算考量

  * 充足预算：考虑Vercel Pro 
  * 有限预算：选择Cloudflare Workers 

##  五、最终建议

🎯 推荐组合：

  * 前端：Vercel部署Next.js 
  * 后端：Cloudflare Workers 

📈 部署策略：

  1. 先使用免费版本测试 
  2. 根据使用情况选择付费方案 
  3. 可同时使用两个平台互补 