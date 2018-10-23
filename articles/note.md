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

但是添加下面任意一个属性之后就会出现开头说的编译错误。

```
@property (nonatomic, assign) int count;
```
```
@property (nonatomic, strong) NSNumber *count;
```

这是为什么呢？

当对 id 类型调用 count 方法的时候，编译器会遍历所有的可见头文件的 count 方法，编译器当然会找到多个定义，因为 count 方法在 NSArray，NSSet 等等这些类上也有实现，而且我声明的 count 方法返回的是一个 int 或者 NSNumber 对象，这和 NSArray，NSSet 等的 count 方法返回NSUInteger 类型不一样，所以编译器会给一个异常。提示有重复的方法签名。

那为什么把 NSArray 转成 id 类型调用 count 方法不会有错呢？

因为Foundation框架的所有 count 方法的返回值都是 一个NSUInteger 类型，编译器找到的签名自然都是一样的。

如果我们把 count 的类型也改成 NSUInteger 或者 NSInteger 就不会报错了。

这里给我们的经验就是

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

返回值CGRect的Size含有小数点，如果使用函数返回值CGRect的Size来定义View大小，必需使用“ceil”函数获取长宽（ceil：大于当前值的最小正数）。

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
