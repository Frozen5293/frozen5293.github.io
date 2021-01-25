---
title: From fprintf to get stderr
layout: page
tags: ProgramDesign
categories: ProgramDesign
date: 2020-02-18 22:40
---
## 去认知stderr为什么返回值是文件流？
> 之前的sqlite数据库的c++调用有了一个不大认识的东西,研究开始！<br>
首先看一下调用这个函数的这个函数<br>
```c++
 fprintf(FILE *stream，char * format,[附加参数]);
                 ^
```
这东西是指向数据的指针。<br>
这个函数可以，输出char*->file *，还能附加参数<br>
再看看它<br>
```c++
【unix】标准输出(设备)文件，对应终端的屏幕。
                                    ----百度百科
```
这是啥？<br>
找到资料回头补充。<br>
顺手做做测试<br>
(https://blog.csdn.net/lengye7/article/details/89162011)


<article>

<b>参考资料：</b><br>


[CSDN]stderr和stdout详细解说(转载)       <a href="https://blog.csdn.net/lengye7/article/details/89162011">https://blog.csdn.net/lengye7/article/details/89162011</a><br>

[百度百科]fprintf                        <a href="https://baike.baidu.com/item/fprintf/10942325?fr=aladdin">https://baike.baidu.com/item/fprintf/10942325?fr=aladdin</a><br>

[百度百科]stderr                         <a href="https://baike.baidu.com/item/stderr/8046227?fr=aladdin">https://baike.baidu.com/item/stderr/8046227?fr=aladdin</a><br>
</article>