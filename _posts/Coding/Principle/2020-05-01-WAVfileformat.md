---
title: WAV file format composition
layout: page
tags: ProgramDesign
categories: ProgramDesign
date: 2020-05-01 21:02
---

#### 关于wav的文件组成代码
from: <https://www.jianshu.com/p/9fdc0eaa2dea>

``` java
/**
     * @param out            wav音频文件流
     * @param totalAudioLen  不包括header的音频数据总长度
     * @param longSampleRate 采样率,也就是录制时使用的频率
     * @param channels       audioRecord的频道数量
    * @param channels       audioRecord的量化精度
     * @throws IOException 写文件错误
     */
    private void writeWavFileHeader(FileOutputStream out, long totalAudioLen, long longSampleRate,
                                    int channels,int audioFormat) throws IOException {
        byte[] header = generateWavFileHeader(totalAudioLen, longSampleRate, channels,audioFormat);
        out.write(header, 0, header.length);
    }

      /**
     * @param totalAudioLen  不包括header的音频数据总长度
     * @param longSampleRate 采样率,也就是录制时使用的频率
     * @param channels       audioRecord的频道数量
     * @param channels       audioRecord的量化精度
     */
    private byte[] generateWavFileHeader(long totalAudioLen, long longSampleRate, int channels，int audioFormat) {
        long totalDataLen = totalAudioLen + 36;
        long byteRate = longSampleRate * 2 * channels;
        byte[] header = new byte[44];
        header[0] = 'R'; // RIFF
        header[1] = 'I';
        header[2] = 'F';
        header[3] = 'F';
        //文件长度  4字节文件长度，这个长度不包括"RIFF"标志(4字节)和文件长度本身所占字节(4字节),即该长度等于整个文件长度 - 8
        header[4] = (byte) (totalDataLen & 0xff);
        header[5] = (byte) ((totalDataLen >> 8) & 0xff);
        header[6] = (byte) ((totalDataLen >> 16) & 0xff);
        header[7] = (byte) ((totalDataLen >> 24) & 0xff);
        //fcc type：4字节 "WAVE" 类型块标识, 大写
        header[8] = 'W';
        header[9] = 'A';
        header[10] = 'V';
        header[11] = 'E';
        //FMT Chunk   4字节 表示"fmt" chunk的开始,此块中包括文件内部格式信息，小写, 最后一个字符是空格
        header[12] = 'f'; // 'fmt '
        header[13] = 'm';
        header[14] = 't';
        header[15] = ' ';//过渡字节
        //数据大小  4字节，文件内部格式信息数据的大小，过滤字节（一般为00000010H）
        header[16] = 16;
        header[17] = 0;
        header[18] = 0;
        header[19] = 0;
        //编码方式 10H为PCM编码格式   FormatTag：2字节，音频数据的编码方式，1：表示是PCM 编码
        header[20] = 1; // format = 1
        header[21] = 0;
        //通道数  Channels：2字节，声道数，单声道为1，双声道为2
        header[22] = (byte) channels;
        header[23] = 0;
        //采样率，每个通道的播放速度
        header[24] = (byte) (longSampleRate & 0xff);
        header[25] = (byte) ((longSampleRate >> 8) & 0xff);
        header[26] = (byte) ((longSampleRate >> 16) & 0xff);
        header[27] = (byte) ((longSampleRate >> 24) & 0xff);
        //音频数据传送速率,采样率*通道数*采样深度/8
        //4字节，音频数据传送速率, 单位是字节。其值为采样率×每次采样大小。播放软件利用此值可以估计缓冲区的大小
        //byteRate = sampleRate * (bitsPerSample / 8) * channels
        header[28] = (byte) (byteRate & 0xff);
        header[29] = (byte) ((byteRate >> 8) & 0xff);
        header[30] = (byte) ((byteRate >> 16) & 0xff);
        header[31] = (byte) ((byteRate >> 24) & 0xff);
        // 确定系统一次要处理多少个这样字节的数据，确定缓冲区，通道数*采样位数
        header[32] = (byte) (2 * channels);
        header[33] = 0;
        //每个样本的数据位数
        //2字节，每个声道的采样精度; 譬如 16bit 在这里的值就是16。如果有多个声道，则每个声道的采样精度大小都一样的；
        header[34] = audioFormat;
        header[35] = 0;
        //Data chunk
        //ckid：4字节，数据标志符（data），表示 "data" chunk的开始。此块中包含音频数据，小写；
        header[36] = 'd';
        header[37] = 'a';
        header[38] = 't';
        header[39] = 'a';
        //音频数据的长度，4字节，audioDataLen = totalDataLen - 36 = fileLenIncludeHeader - 44
        header[40] = (byte) (totalAudioLen & 0xff);
        header[41] = (byte) ((totalAudioLen >> 8) & 0xff);
        header[42] = (byte) ((totalAudioLen >> 16) & 0xff);
        header[43] = (byte) ((totalAudioLen >> 24) & 0xff);
        return header;
    }
```
- _术语解释_
- - 采样率：计算机每秒钟采集多少个信号样本，就是每秒采集多少个值


#### 关于低字节序与高字节序的转换
<https://www.cnblogs.com/lyghost/p/5148885.html>

``` java
1 // 翻转字节顺序 (16-bit)
2 public static UInt16 ReverseBytes(UInt16 value)
3 {
4   return (UInt16)((value & 0xFFU) << 8 | (value & 0xFF00U) >> 8);
5 }

```

``` java
1 // 翻转字节顺序 (32-bit)
2 public static UInt32 ReverseBytes(UInt32 value)
3 {
4   return (value & 0x000000FFU) << 24 | (value & 0x0000FF00U) << 8 |
5          (value & 0x00FF0000U) >> 8 | (value & 0xFF000000U) >> 24;
6 }

```
``` java
1 // 翻转字节顺序 (64-bit)
2 public static UInt64 ReverseBytes(UInt64 value)
3 {
4   return (value & 0x00000000000000FFUL) << 56 | (value & 0x000000000000FF00UL) << 40 |
5          (value & 0x0000000000FF0000UL) << 24 | (value & 0x00000000FF000000UL) << 8 |
6          (value & 0x000000FF00000000UL) >> 8 | (value & 0x0000FF0000000000UL) >> 24 |
7          (value & 0x00FF000000000000UL) >> 40 | (value & 0xFF00000000000000UL) >> 56;
8 }
```
这边文章是介绍如何在 Markdown 中增加文献引用。[<sup>336</sup>](#336)

- 关于反转字节的计算方式解释
- 我们 假设一个 二字节数  1100  0010 1100 0001 让这个数 & 0000 0000 1111 1111 然后*2^8 就把第一个字节 置空 换到第二个字节 同理 把第二个字节置空 换到第一个字节 然后与运算 就能得到一个二字节数 第一个字节和第二个字节换过来

<https://www.jianshu.com/p/1d1f893e53e9>


```java
private RandomAccessFile fopen(String path) throws IOException {
    File f = new File(path);

    if (f.exists()) {
        f.delete();
    } else {
        File parentDir = f.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }
    }

    RandomAccessFile file = new RandomAccessFile(f, "rw");
    // 16K、16bit、单声道
    /* RIFF header */
    file.writeBytes("RIFF"); // riff id
    file.writeInt(0); // riff chunk size *PLACEHOLDER*
    file.writeBytes("WAVE"); // wave type

    /* fmt chunk */
    file.writeBytes("fmt "); // fmt id
    file.writeInt(Integer.reverseBytes(16)); // fmt chunk size
    file.writeShort(Short.reverseBytes((short) 1)); // format: 1(PCM)
    file.writeShort(Short.reverseBytes((short) 1)); // channels: 1
    file.writeInt(Integer.reverseBytes(16000)); // samples per second
    file.writeInt(Integer.reverseBytes((int) (1 * 16000 * 16 / 8))); // BPSecond
    file.writeShort(Short.reverseBytes((short) (1 * 16 / 8))); // BPSample
    file.writeShort(Short.reverseBytes((short) (1 * 16))); // bPSample

    /* data chunk */
    file.writeBytes("data"); // data id
    file.writeInt(0); // data chunk size *PLACEHOLDER*

    Log.d(TAG, "wav path: " + path);
    return file;
}

private void fwrite(RandomAccessFile file, byte[] data, int offset, int size) throws IOException {
    file.write(data, offset, size);
    Log.d(TAG, "fwrite: " + size);
}

private void fclose(RandomAccessFile file) throws IOException {
    try {
        file.seek(4); // riff chunk size
        file.writeInt(Integer.reverseBytes((int) (file.length() - 8)));

        file.seek(40); // data chunk size
        file.writeInt(Integer.reverseBytes((int) (file.length() - 44)));

        Log.d(TAG, "wav size: " + file.length());

    } finally {
        file.close();
    }
}
```

举个例子可以这么写

---

RIFF||4b|big
文件长度-8||4b|little
WAVE||4b|big

---

上面这段就是文件类型的声明

---

fmt+半角空格|4b|big
声音编码方式决定的单位读取长度|4b|little
声音编码格式的代码|2b|little
声道数|2b|little
采样频率（单位时间采样数）|4b|little
数据传输速率（声道数\*采样频率\*每样本的数据位数/8）|4b|little
这个是 单位时间的 数据大小|-|-
数据块对齐单位（声道数\*采样位数/8）|2b|little
这个是 单位声音 响度数据大小|-|-
采样位数|2b|little

---

这段是 音频格式的解释

---

data|4b|big
size（声道数\*采样数目\*每样本的数据位数/8）|4b|little
这个是数据大小|-- |--
【】|【波】|【波】

--- 

这段是数据

## 名词解释：
> 声音采样就是获取一个声音的 
>振幅（响度） 
>频率（音调） 
>波形（音色）

- 这里就可以这么写了[音调频率][3]
























[3]: https://pages.mtu.edu/~suits/notefreqs.html "音调"





<div id="336"></div>

-  [336] [百度学术](http://xueshu.baidu.com/)

<div id="2"></div>

- [2] [Wikipedia](https://en.wikipedia.org/wiki/Main_Page)