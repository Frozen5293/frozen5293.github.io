---
title: ModifyGameWithODAndCE(连载中)(准备上传文件)
layout: page
tags: Gamedesign
categories: GameDesign
date: 2019-12-5 15:46
---
## __童年的纸飞机飞回我手里__
<hr/>

- 我怎么也没想到，当时一点看不懂的CE，现在能够看懂了，看了[B站上的视频](https://www.bilibili.com/video/av77758280)
  > <iframe src="//player.bilibili.com/player.html?aid=77758280&cid=133021550&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>
  > 虽然我只看了最后3P（我承认我是被标题吸引进去的）。。。
  > 之前可以做到使用[CE](https://github.com/cheat-engine/cheat-engine)改数值
  > 当时并不知道内存的原理只是知道搜索数值，大的、小的、未知的，我记得还有一节当时完全看不懂的指针。

### 知识点
- 1.代码在内存中紧密排列，不会空（NOP除外）。
- 2.通过字符的搜索可以找到内存地址。
- 3.CE中有找出是什么改写了这个地址
- 4.分析代码的组成，猜测原函数

```
- if语句（jnz）中有一个跳转，每一个分支都有一个return。
- "mov a,b"即"a=b".一种做法是将edi改写，但是推荐改写常量，可以找edi的赋值语句，
- "sub a,b"即"a-=b".分析游戏结构，找到修改的关键点。
- 但是特殊僵尸并不受影响，说明游戏的结构，并不是仅仅是这样。
```

___可以分析一下特殊僵尸作为作业___

<hr>

