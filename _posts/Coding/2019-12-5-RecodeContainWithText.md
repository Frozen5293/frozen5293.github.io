---
title: RecodeContainWithText(连载中)(缺少测试)
layout: page
tags: ProgramDesign
categories: ProgramDesign
date: 2019-12-5 2:20
---
<article>
    <h1>怎样把文本文件当作数据库</h1>
        <p class="interview">
            如果你有COC（TRPG）的表，生成一个txt文档，或许它能够成为简单的数据库了（虽然只有一行）。<!--灰色小字部分-->
        </p>
        <p>
		    <span class="texttitle">1.将它存储为一个vector（长度不确定）根据位置获取数据。</span>
		    <pre>	
	将文本初始化，符号空格该删的删。
	新建一个文本文档生成一个总的关系,也就是表头的顺序，然后导出覆盖。当要读取文件的时候，就可以先读取表头文件的关系。
优点：当数量少时，方便人为查阅。更改一个人物卡不会对其他人物卡造成影响。
缺点：会生成一大堆文件。
			</pre>
			<span class="texttitle">2.将它存储为一个vector（长度确定）根据位置获取数据。</span>>
			<pre>
	将文本初始化，符号空格该删的删，需要的话要补NULL。
	新建一个文本文档创建一个总的关系,也就是表头的顺序。当要读取文件的时候，就可以先读取表头文件的关系。
优点：便于读取识别。
缺点：人物卡数量少时，查找的时候不方便（有许多NULL,而且挺长），不能进行个人的格式更改，如果要改全都要动。
			</pre>
		</p>
</article>