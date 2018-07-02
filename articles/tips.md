# Tips
## 1. 静态变量初始化
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