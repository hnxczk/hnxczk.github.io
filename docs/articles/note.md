---
sidebar: auto
---

# 笔记

## 接入某个 SDK 后报 count 方法错误

`multiple methods named 'count' found with mismatched result, parameter type or attributes.`

昨天在添加某个第三方 SDK 后编译出错，提示上面的错误。报错的位置都是类似下面这种。

```
[[dataArray objectAtIndex:section] count]
```
简单总结就是对一个 id 类型修饰的变量调用 count 方法会报错。

Google 了一下大家给出的解决方案都是这样来修改代码
```
[(NSArray *)[dataArray objectAtIndex:section] count]
```
将 id 类型强转为 NSArray 类型。这样编译器就不会报错了。

下面来复现下出现问题的步骤。

测试代码
```
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@[@"", @""]];
    [array addObject:@[@"", @""]];
    [array addObject:@[@"", @""]];

    id a = array[1];
    NSInteger count = [a count];
    
    NSLog(@"%ld", count);
}
@end
```
经测试上面的代码是不会报错的。

但是为 ViewController 或者任意类添加下面任意一个属性之后就会出现开头说的编译错误。

```
@property (nonatomic, assign) int count;
```
```
@property (nonatomic, strong) NSNumber *count;
```

这是为什么呢？

当对 id 类型调用 count 方法的时候，编译器会遍历所有的可见头文件的 count 方法，编译器当然会找到多个定义，因为 count 方法在 NSArray，NSSet 等等这些类上也有实现，而且我声明的 count 方法返回的是一个 int 或者 NSNumber 对象，这和 NSArray，NSSet 等的 count 方法返回NSUInteger 类型不一样，所以编译器会给一个异常。提示有重复的方法签名。

那为什么把 NSArray 转成 id 类型调用 count 方法不会有错呢？

因为Foundation框架的所有 count 方法的返回值都是 一个 NSUInteger 类型，编译器找到的签名自然都是一样的。

如果我们把 count 的类型也改成 NSUInteger 或者 NSInteger 就不会报错了。

总的来说这就是编译器做的一些优化，到运行时调用方法就成了消息发送，这时候会根据运行时的类型去查找对应的方法。

这里给我的经验就是

1. 尽量不要使用 count 的属性或方法。把 count 当成关键字就行了。
2. 尽可能的使用类型转换。能不用 id 就别用。

## 准确计算 string 的 size

在 iOS7 之后的项目中遇到计算 string 的 size 往往利用下面的方法计算

```
- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes context:(nullable NSStringDrawingContext *)context NS_AVAILABLE(10_11, 7_0);
```

- 参数一：size 表示计算文本的最大宽高(就是限制的最大高度、宽度)。

- 参数二：options 表示计算的类型
    1. `NSStringDrawingUsesLineFragmentOrigin`: 整个文本将以每行组成的矩形为单位计算整个文本的尺寸

    2. `NSStringDrawingUsesFontLeading`: 使用字体的行间距来计算文本占用的范围，即每一行的底部到下一行的底部的距离计算

    3. `NSStringDrawingUsesDeviceMetrics`: 将文字以图像符号计算文本占用范围，而不是以字符计算。也即是以每一个字体所占用的空间来计算文本范围

    4. `NSStringDrawingTruncatesLastVisibleLine`: //当文本不能适合的放进指定的边界之内，则自动在最后一行添加省略符号。如果 `NSStringDrawingUsesLineFragmentOrigin`没有设置，则该选项不生效

- 参数三：attributes 表示富文本的属性 NSAttributedString 比如字体、文字样式 NSFontAttributeName、NSParagraphStyleAttributeName

- 参数四：NSStringDrawingContext context上下文，包括一些信息，例如如何调整字间距以及缩放。该参数一般可为 nil 。

一般使用 `NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading` 这两个配置。

即使是这样计算出来的尺寸依然会有微小的差距。根据经验在获取高度时 +1 就可以解决这一问题，这又是为什么呢？

后来找到了下面这句话。
> This method returns the actual bounds of the glyphs in the string. Some of the glyphs (spaces, for example) are allowed to overlap the layout constraints specified by the size passed in, so in some cases the width value of the size component of the returned CGRect can exceed the width value of the size parameter.

返回值 CGRect 的 Size 含有小数点，如果使用函数返回值 CGRect 的 Size 来定义 View 大小，必需使用 “ceil” 函数获取长宽（ceil：大于当前值的最小正数）。

这样就解释了为什么 +1 就能解决这一问题了。

所以应当使用下面的方法来计算 string 的 size。

```
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize realSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return CGSizeMake(ceilf(realSize.width), ceilf(realSize.height));
}
```

参考：
- [https://www.jianshu.com/p/c615a76dace2](https://www.jianshu.com/p/c615a76dace2)
- [http://mrpeak.cn/blog/uilabel/](http://mrpeak.cn/blog/uilabel/)
- [https://blog.csdn.net/xjkstar/article/details/47165983](https://blog.csdn.net/xjkstar/article/details/47165983)

## 截图

最近在做一个视频截图的功能，在这里记录一下遇到的问题。

iOS 上显示的图像根据绘制机制的不同大致可以分为 UIKit, Quartz, OpenGL ES, SpriteKit 等等。在截图的时候用到的方法也不尽相同。

### 一般视图

对于一般的视图，比如创建的 View 以及通过 Core Graphics 绘制的图形。这些都可以通过下面的方法来获取其截图。
```
- (UIImage *)viewToImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
```

### OpenGL

通过 OpenGL 绘制的视图来说，上面的方法是不起作用的，需要使用下面的方法

```
// IMPORTANT: Call this method after you draw and before -presentRenderbuffer:.
- (UIImage*)snapshot:(UIView*)eaglview
{
    GLint backingWidth, backingHeight;
 
    // Bind the color renderbuffer used to render the OpenGL ES view
    // If your application only creates a single color renderbuffer which is already bound at this point,
    // this call is redundant, but it is needed if you're dealing with multiple renderbuffers.
    // Note, replace "_colorRenderbuffer" with the actual name of the renderbuffer object defined in your class.
    // glBindRenderbufferOES(GL_RENDERBUFFER, _colorRenderbuffer);
 
    // Get the size of the backing CAEAGLLayer
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
 
    NSInteger x = 0, y = 0, width = backingWidth, height = backingHeight;
    NSInteger dataLength = width * height * 4;
    GLubyte *data = (GLubyte*)malloc(dataLength * sizeof(GLubyte));
 
    // Read pixel data from the framebuffer
    glPixelStorei(GL_PACK_ALIGNMENT, 4);
    glReadPixels(x, y, width, height, GL_RGBA, GL_UNSIGNED_BYTE, data);
 
    // Create a CGImage with the pixel data
    // If your OpenGL ES content is opaque, use kCGImageAlphaNoneSkipLast to ignore the alpha channel
    // otherwise, use kCGImageAlphaPremultipliedLast
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef iref = CGImageCreate(width, height, 8, 32, width * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                    ref, NULL, true, kCGRenderingIntentDefault);
 
    // OpenGL ES measures data in PIXELS
    // Create a graphics context with the target size measured in POINTS
    NSInteger widthInPoints, heightInPoints;
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
        // Set the scale parameter to your OpenGL ES view's contentScaleFactor
        // so that you get a high-resolution snapshot when its value is greater than 1.0
        CGFloat scale = eaglview.contentScaleFactor;
        widthInPoints = width / scale;
        heightInPoints = height / scale;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthInPoints, heightInPoints), NO, scale);
    }
    else {
        // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
        widthInPoints = width;
        heightInPoints = height;
        UIGraphicsBeginImageContext(CGSizeMake(widthInPoints, heightInPoints));
    }
 
    CGContextRef cgcontext = UIGraphicsGetCurrentContext();
 
    // UIKit coordinate system is upside down to GL/Quartz coordinate system
    // Flip the CGImage by rendering it to the flipped bitmap context
    // The size of the destination area is measured in POINTS
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, widthInPoints, heightInPoints), iref);
 
    // Retrieve the UIImage from the current context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
 
    UIGraphicsEndImageContext();
 
    // Clean up
    free(data);
    CFRelease(ref);
    CFRelease(colorspace);
    CGImageRelease(iref);
 
    return image;
}
```

这个方法出自 [Apple 文档：OpenGL ES View Snapshot](https://developer.apple.com/library/archive/qa/qa1704/_index.html#//apple_ref/doc/uid/DTS40010204)。

注意

1. Apple 文档中的例子是针对 Mac 平台的，iOS 平台需要修改成上面的这样。
2. 上面代码中 `glBindRenderbufferOES(GL_RENDERBUFFER, _colorRenderbuffer);` 被注释掉了。按照说明，当你的 APP 中只有 一个 renderbuffer 的时候可以省掉这句代码，否则需要指定 renderbuffer。 
3. 经过测试在 iOS9+ 的系统上上面的代码可以正常截图，但是在 iOS8 系统的 iPhone5 上，上面代码不能正常截图，不知道是 iOS8 系统的原因还是 iPhone5 32 位系统的原因
4. 也有下面的写法，效果都是一样的

```
- (UIImage *)renderImg
{
        GLint backingWidth = 0;
        GLint backingHeight = 0;
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
        GLubyte *buffer = (GLubyte *) malloc(backingWidth * backingHeight * 4);
        GLubyte *buffer2 = (GLubyte *) malloc(backingWidth * backingHeight * 4);

        glReadPixels(0, 0, backingWidth, backingHeight, GL_RGBA, GL_UNSIGNED_BYTE,
                     (GLvoid *)buffer);
        for (int y=0; y<backingHeight; y++) {
            for (int x=0; x<backingWidth*4; x++) {
                buffer2[y * 4 * backingWidth + x] =
                buffer[(backingHeight - y - 1) * backingWidth * 4 + x];
            }
        }
        free(buffer);
        CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2,
                                                                  backingWidth * backingHeight * 4,
                                                                  myProviderReleaseData);
        // set up for CGImage creation
        int bitsPerComponent = 8;
        int bitsPerPixel = 32;
        int bytesPerRow = 4 * backingWidth;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        // Use this to retain alpha
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
        CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
        CGImageRef imageRef = CGImageCreate(backingWidth, backingHeight,
                                            bitsPerComponent, bitsPerPixel,
                                            bytesPerRow, colorSpaceRef,
                                            bitmapInfo, provider,
                                            NULL, NO,
                                            renderingIntent);
        // this contains our final image.
        UIImage *newUIImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorSpaceRef);
        CGDataProviderRelease(provider);

        return newUIImage;
}
```

需要注意宽高建议都通过下面的代码获取，千万不要通过 view 的 size 和 屏幕的 scale 来计算（对于 iPhone6 plus 这一系列尺寸的屏幕来说需要额外除去 downsampling - 1.15）。
```
GLint backingWidth = 0;
GLint backingHeight = 0;
glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
```

### 通过 UIView 的 `-drawViewHierarchyInRect:afterScreenUpdates:` 方法

这个方法也是来自 [Apple 文档：View Snapshots on iOS 7](https://developer.apple.com/library/archive/qa/qa1817/_index.html)。

> This new method -drawViewHierarchyInRect:afterScreenUpdates: enables you to capture the contents of the receiver view and its subviews to an image regardless of the drawing techniques (for example UIKit, Quartz, OpenGL ES, SpriteKit, etc) in which the views are rendered

根据说明可以看出来这个方法对于 UIKit, Quartz, OpenGL ES, SpriteKit等技术实现渲染的控件都能截图。

```
- (UIImage *)snapshot:(UIView *)view
{
    if (CGRectIsEmpty(view.frame)) {
        return nil;
    }

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return image;
}
```
有些同学反馈说这个方法会在 iOS7 上 crash。为了安全起见，参考了 [这里](https://blog.csdn.net/taishanduba/article/details/52156850)这个同学的建议，在 Apple 提供的解决方法上做了一些修改。

- 添加 frame 为 empty 的判断
- afterScreenUpdates 的参数设置为 NO

### AVFoundation

对于通过 AVFoundation 实现的的视频播放来说上面的方法都无法获取截图，需要使用 AVFoundation 的 AVPlayerItemVideoOutput 来获取 pixelBuffer 实现截图功能。

```
self.playerItem = [AVPlayerItem playerItemWithURL:url];
self.PlayerItemVideoOutput = [[AVPlayerItemVideoOutput alloc] init];
[self.playerItem addOutput:self.PlayerItemVideoOutput];
```

在创建播放的 AVPlayerItem 的时候添加 AVPlayerItemVideoOutput。

```
CMTime itemTime = self.playerItem.currentTime;
CVPixelBufferRef pixelBuffer = [self.PlayerItemVideoOutput copyPixelBufferForItemTime:itemTime itemTimeForDisplay:nil];
CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
CIContext *temporaryContext = [CIContext contextWithOptions:nil];
CGImageRef videoImage = [temporaryContext
                             createCGImage:ciImage
                             fromRect:CGRectMake(0, 0,
                                    CVPixelBufferGetWidth(pixelBuffer),
                                    CVPixelBufferGetHeight(pixelBuffer))];
UIImage *frameImg = [UIImage imageWithCGImage:videoImage]    CGImageRelease(videoImage);
```
然后通过 AVPlayerItemVideoOutput 的 `copyPixelBufferForItemTime` 方法获取到 CVPixelBufferRef，然后转化为 UIImage。

### 参考

- [OpenGL ES View Snapshot](https://developer.apple.com/library/archive/qa/qa1704/_index.html#//apple_ref/doc/uid/DTS40010204)
- [View Snapshots on iOS 7](https://developer.apple.com/library/archive/qa/qa1817/_index.html)
- [UIGraphics crashes on iOS 7](https://stackoverflow.com/questions/19903665/uigraphics-crashes-on-ios-7)
- [记录iOS7截图drawViewHierarchyInRect:afterScreenUpdates崩溃](https://blog.csdn.net/taishanduba/article/details/52156850)

- [AVPlayer直播视频截图](https://www.jianshu.com/p/753a6e8cd90a)

## 静态变量初始化
今天在跟一个朋友在讨论使用串行队列保证线程安全的时候遇到了一个编译错误。代码如下。

```
static dispatch_queue_t serialQueue = dispatch_queue_create("static", NULL);

@implementation Student

@synthesize age = _age;

- (NSInteger)age
{
    __block NSInteger age = 0;
    dispatch_sync(serialQueue, ^{
        age = self->_age;
    });
    return age;
}

- (void)setAge:(NSInteger)age
{
    dispatch_async(serialQueue, ^{
        self->_age = age;
    });
}

@end
```
在声明静态全局串行队列的时候报 `Initializer element is not a compile-time constant` 的错误。

后来在[这里](https://stackoverflow.com/questions/12304740/initializer-element-is-not-a-compile-time-constant-why)找到了相关解释。
大意就是在 C 和 Objective-C 中全局变量的值要在编译时确定，不能在执行时确定。

```
static NSInteger i = 6 + 3;
```
上面这个代码是不会报错的。
但是换成下面这个的话就会报错。
```
static NSInteger a = 6;
static NSInteger b = 3;
static NSInteger i = a + b;
```

解决办法的话大致有以下几种
1. 由于 ` C++ 和 Objective-C++ are more lenient and allow non-compile-time constants.` 因此自接把当前 .m 文件修改成 .mm 就可以了。
2. 在声明的时候赋值为 nil 然后在方法中赋值。

```
static dispatch_queue_t serialQueue = nil;

@implementation Student

@synthesize age = _age;

+ (void)initialize
{
    serialQueue = dispatch_queue_create("static", NULL);
}

- (NSInteger)age
{
    __block NSInteger age = 0;
    dispatch_sync(serialQueue, ^{
        age = self->_age;
    });
    return age;
}

- (void)setAge:(NSInteger)age
{
    dispatch_async(serialQueue, ^{
        self->_age = age;
    });
}

@end
```

另外需要注意的是如果把 `age = self->_age;` 中的 `self->` 去掉的话会提示 `Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior` 的警告⚠️。这其实只是提醒我们只写 `_age` 的时候 self 也会被 block 所捕获，需要注意循环引用的问题。加上 `self->` 可以让我们更清楚这个捕获的存在。当然现在这个用法是不会出现循环引用的。

## 使用 gem 安装 cocoapods 等，报错 `You don't have write permissions for the /Library/Ruby/Gems/2.3.0 directory.`

字面意思就是没有往这个目录写文件的权限。网上大部分文章都说可以通过下面的命令来完成安装。

```
sudo gem install cocoapods -n /usr/local/bin
```

我使用 `gem install help` 查看了一下这个命令的说明，上面的命令就是利用管理员权限把 cocoapods 安装到 `/usr/local/bin` 目录下。

这种也能解决问题，不过每次使用 gem 安装都需要使用这种命令，有没有更好的方法呢？

还真有！而且解释了为什么会出现这种情况。

我们都知道 mac 都是自带 ruby 的，其路径就是 `/Library/Ruby`。 而当使用 gem 安装东西的时候就会往系统的 `/Library` 中添加东西，因此需要管理员的权限。

这样以来解决的办法就是自己安装一个 ruby , 使其与系统自带的区分开。

### 解决步骤

1. 使用 rvm 安装 ruby 环境

```
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
```

>需要注意的是我第一次安装的时候提示秘钥失效的错误需要使用西面的命令

>```
>command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
>command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
>```

2. 使用 rvm 安装 ruby

```
rvm list known // 查看支持的版本
sudo rvm install --force 2.6 // 安装特定的版本
rvm 2.6 --default // 设置
```

3. 安装 cocoapods

```
gem install cocoapods
```

### 参考

1. [Mac更新Ruby环境及可能遇到的问题](https://www.jianshu.com/p/42ff2255f0b3)
2. [How do I fix the “You don't have write permissions into the /usr/bin directory” error when installing Rails?](https://stackoverflow.com/questions/2893889/how-do-i-fix-the-you-dont-have-write-permissions-into-the-usr-bin-directory)
3. [Mac OS X 下使用 Ruby Gem 的两个坑](https://www.jianshu.com/p/bb9fe3fd45d0)