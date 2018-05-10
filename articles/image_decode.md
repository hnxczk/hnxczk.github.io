# 图片的编码与解码
## 图片加载
iOS 提供了两种加载图片方法，分别是 UIIImage 的 imageNamed: 和 UIIImage 的imageWithContentsOfFile:
### imageNamed
> Returns the image object associated with the specified filename.
This method looks in the system caches for an image object with the specified name and returns the variant of that image that is best suited for the main screen. If a matching image object is not already in the cache, this method locates and loads the image data from disk or from an available asset catalog, and then returns the resulting object.

>The system may purge cached image data at any time to free up memory. Purging occurs only for images that are in the cache but are not currently being used.
In iOS 9 and later, this method is thread safe.

imageNamed: 方法的特点在于可以缓存已经加载的图片；使用时，先根据文件名在系统缓存中寻找图片，如果找到了就返回；如果没有，就在 Bundle 内查找到文件名，找到后把这个文件名放到 UIImage 里返回，并没有进行实际的文件读取和解码。当 UIImage 第一次显示到屏幕上时，其内部的解码方法才会被调用，同时解码结果会保存到一个全局缓存去。在图片解码后，App **第一次退到后台和收到内存警告**时，该图片的缓存才会被清空，其他情况下缓存会一直存在。

### imageWithContentsOfFile

> Creates and returns an image object by loading the image data from the file at the specified path.

>This method does not cache the image object.

由上面的文档我们可以知道该方法直接返回图片，不会缓存。而且其解码依然要等到第一次显示该图片的时候。

### 图片加载的流程
>1. 假设我们使用 +imageWithContentsOfFile: 方法从磁盘中加载一张图片，这个时候的图片并没有解压缩；
2. 然后将生成的 UIImage 赋值给 UIImageView ；
3. 接着一个隐式的 CATransaction 捕获到了 UIImageView 图层树的变化；
4. 在主线程的下一个 run loop 到来时，Core Animation 提交了这个隐式的 transaction ，这个过程可能会对图片进行 copy 操作，而受图片是否字节对齐等因素的影响，这个 copy 操作可能会涉及以下部分或全部步骤：
	1. 分配内存缓冲区用于管理文件 IO 和解压缩操作；
	2. 将文件数据从磁盘读到内存中；
	3. 将压缩的图片数据解码成未压缩的位图形式，这是一个非常耗时的 CPU 操作；
	4. 最后 Core Animation 使用未压缩的位图数据渲染 UIImageView 的图层。

>在上面的步骤中，图片的解码是一个非常耗时的 CPU 操作，并且它默认是在主线程中执行的。那么当需要加载的图片比较多时，就会对我们应用的响应性造成严重的影响，尤其是在快速滑动的列表上，这个问题会表现得更加突出。

## 为什么需要编解码
要想知道这个原因就需要了解图片格式的几个概念
### 图片格式
#### 位图 

>A bitmap image (or sampled image) is an array of pixels (or samples). Each pixel represents a single point in the image. JPEG, TIFF, and PNG graphics files are examples of bitmap images.

位图就是一个像素数组，数组中的每个像素就代表着图片中的一个点。

#### JPEG、PNG
他们都是一种压缩的位图图形格式。只不过 PNG 图片是无损压缩，并且支持 alpha 通道，而 JPEG 图片则是有损压缩，可以指定 0-100% 的压缩比。

### 解码
我们不论是通过网络下载的还是本地的图片基本上都是 JPEG、PNG 这些格式的压缩图片。而在将这些图片渲染到屏幕之前，必须先要得到图片的原始像素数据，才能执行后续的绘制操作，这就是为什么需要对图片解压缩的。

而且这个解码工作是比较耗时的，不能使用 GPU 硬解码，只能通过 CPU 软解码实现（硬解码是通过解码电路实现，软解码是通过解码算法、CPU 的通用计算等方式实现软件层面的解码，效率不如 GPU 硬解码）。

iOS 默认会在主线程对图像进行解码，解压缩后的图片大小与原始文件大小之间没有任何关系，而只与图片的像素有关：

```
解压缩后的图片大小 = 图片的像素宽  * 图片的像素高  * 每个像素所占的字节数 
```
(这个**每个像素所占的字节数**取决于**像素格式**更多相关的信息可以查看 [这里](http://blog.leichunfeng.com/blog/2017/02/20/talking-about-the-decompression-of-the-image-in-ios/#jtss-tsina))

## SDWebImage
SDWebImage中使用以下策略：

- 当图片从网络中获取到的时候就进行解压缩。
- 当图片从磁盘缓存中获取到的时候立即解压缩。

## 参考
1. [谈谈 iOS 中图片的解压缩](http://blog.leichunfeng.com/blog/2017/02/20/talking-about-the-decompression-of-the-image-in-ios/#jtss-tsina)
2. [篇1：SDWebImage源码看图片解码](https://www.jianshu.com/p/728f71b9fe28)
3. [iOS 处理图片的一些小 Tip](https://blog.ibireme.com/2015/11/02/ios_image_tips/)
4. [SDWebImage源码解析（三）——SDWebImage图片解码/压缩模块](https://www.jianshu.com/p/dfa47380fc05)
5. [@Swift开发者大会——如何打造易扩展的高性能图片组件](https://zhuanlan.zhihu.com/p/26955368)