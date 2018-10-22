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
将 id 类型强转为 NSArray 类型。这样编译器就不会报错了。

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

但是添加下面任意一个属性之后就会出现开头说的编译错误。

```
@property (nonatomic, assign) int count;
```
```
@property (nonatomic, strong) NSNumber *count;
```

这是为什么呢？

当对 id 类型调用 count 方法的时候，编译器会遍历所有的可见头文件的 count 方法，编译器当然会找到多个定义，因为 count 方法在 NSArray，NSSet 等等这些类上也有实现，而且我声明的 count 方法返回的是一个 int 或者 NSNumber 对象，这和 NSArray，NSSet 等的 count 方法返回NSUInteger 类型不一样，所以编译器会给一个异常。提示有重复的方法签名。

那为什么把 NSArray 转成 id 类型调用 count 方法不会有错呢？

因为Foundation框架的所有 count 方法的返回值都是 一个NSUInteger 类型，编译器找到的签名自然都是一样的。

如果我们把 count 的类型也改成 NSUInteger 或者 NSInteger 就不会报错了。

这里给我们的经验就是

1. 尽量不要使用 count 的属性或方法。把 count 当成关键字就行了。
2. 尽可能的使用类型转换。能不用 id 就别用。