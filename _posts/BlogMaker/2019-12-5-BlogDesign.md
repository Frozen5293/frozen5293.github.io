---
title: BlogDesign(连载中)
layout: page
tags: ProgramDesign
categories: ProgramDesign
date: 2019-12-5 1:22
---
## __2019-12-5 1:27__
- 暂时完成了改动，但是不知道标签是咋回事
- 这个地方将会持续记录，看看index.html到底写的什么东西。
- 看情况重写一遍css（应该不会没有这么多时间）
- 看板娘位置放右边，左边的要有人性化的交互（务必）
- [markdown的写法](https://www.runoob.com/markdown/md-link.html)
- 教程[jekyll](https://www.youtube.com/watch?v=T1itpPvFWHI&list=PLLAZ4kZ9dFpOPV5C5Ay0pHaa0RJFhcmcB)

## __2020-04-04 18:43__
- 首先jekyll 需要ruby2.4
- 然后windows需要装ruby的时候在弹出的cmd窗口1 2 3选项选择一遍
- 还有安装Nokogiri才能跑起来ruby
- > 
```
choco install libxml2 -Source "https://www.nuget.org/api/v2/"
choco install libxslt -Source "https://www.nuget.org/api/v2/"
choco install libiconv -Source "https://www.nuget.org/api/v2/"
```
```
gem install nokogiri --^
   --with-xml2-include=C:\Chocolatey\lib\libxml2.2.7.8.7\build\native\include^
   --with-xml2-lib=C:\Chocolatey\lib\libxml2.redist.2.7.8.7\build\native\bin\v110\x64\Release\dynamic\cdecl^
   --with-iconv-include=C:\Chocolatey\lib\libiconv.1.14.0.11\build\native\include^
   --with-iconv-lib=C:\Chocolatey\lib\libiconv.redist.1.14.0.11\build\native\bin\v110\x64\Release\dynamic\cdecl^
   --with-xslt-include=C:\Chocolatey\lib\libxslt.1.1.28.0\build\native\include^
   --with-xslt-lib=C:\Chocolatey\lib\libxslt.redist.1.1.28.0\build\native\bin\v110\x64\Release\dynamic
```

## __2020-06-17 17：24：06__
- 安装gitpage
- > 
```ruby
gem install bundler
```
- > 在你的博客根目录中创建名为 Gemfile 不带任何后缀名的文件
- 

## __markdown笔记__
- ```
用法1//这个是论文的引用
[书名][1]
1. [书名][1]<aaaaa>
[1]:aaaaa

用法2//这个是跳转的方式
[目录](#1)
[第一章](#1.1)

<a id="1"></a>
```
## __目录__

    - __预计改动__
    1. 由于删了许多文件，应该能简化一下代码【懒】
    2. js的运行时间不太对...【删了】
    3. _config.yml 文件中有不少多的东西能删则删。【删了】
    4. 让h标签不能被点击。。。【完成】
    - __接下来的工作__
    1. 博客试着能不能用html和MD一起写，总感觉这个博客的格式我需要小字和小标题啥的。
    - - 好像可以，但是不能html里面带md【完成】
    2. 下次把文章分类做了<br/>例如：按类型<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;按月份【随便吧】
<hr/>
