# 装饰者模式

购买咖啡的时候顾客可以要求加入各种调料，而咖啡最后会根据加入调料的不同和多少来收取不同的费用。因此在构建咖啡这个需求的时候，按照面向对象的思想最直接想到的就是抽象出来一个咖啡的父类，然后有各种调料对应的属性。同时咖啡的费用通过 `cost` 方法来获取，方法里面会计算好各种调料的份额和价钱然后算出总价。添加新的口味咖啡的时候就继承自咖啡这个父类来实现。并且新口味咖啡这些子类会重写并调用父类的 `cost` 来实现价格的计算。具体如下图。

![](./images/03-decorate-pattern-2.png)

上面的例子可以解决部分问题，但是当遇到一些需求变更，比如某种调料的价格发生的变动或者要加入新的调料的种类的时候我们都需要修改父类。这样以来程序的扩展性就出现了问题。

## 开放-关闭原则

**类应该对扩展开放，对修改关闭**

这是因为在实际的开发过程中总是伴随着新的需求，这就要求我们要有开放的能力来承接新的需求，但是是如果直接修改代码的话就会不可避免的引进 bug 或者产生意外的副作用。因此我们在设计代码的时候应该对扩展开放，而对修改关闭。

![](./images/03-decorate-pattern-3.png)

> **ps** 让程序中所有的地方都遵循`开发-关闭`原则并不是一个好的设计。因为在遵循该原则的时候通常会引进新的抽象层级，增加代码的复杂度。因此需要根据工作领域的了解和设计经验来找出需要扩展的部分来遵循开发-关闭的设计原则。

## 定义

动态的将责任附加到对象上。若要扩展功能，装饰者提供了比继承更有弹性的替代方案。

个人感觉就是在扩展功能的时候生成一个装饰者，提供了一些扩展功能，并且该装饰者与被装饰者有相同的父类，这样以来所有需要被装饰者的地方都可以使用装饰者代替。

一个形象的比喻就是画和画框，画是被装饰者，画框是装饰者。画是不能直接挂到墙上的，现在把画放到画框中就可以挂到墙上了，这就是扩展功能。并且这样也没有涉及到修改画。而之前画的功能就是被欣赏，现在画和画框也能被欣赏。

## 具体实现
![](./images/03-decorate-pattern-4.png)

具体的实现及说明可以查看[代码](./code/03-decorrate-pattern)

需要说明以下几点：

1. 由于 OC 中无法声明抽象类，因此在抽象类的 init 方法和抽象方法上加上断言来实现子类必须重写的这一需求。

```
- (instancetype)init
{
    NSAssert(![self isMemberOfClass:[Beverage class]], @"AbstractDownloader is an abstract class, you should not instantiate it directly.");
    return [super init];
}
```

2. 分析一下装饰者模式的具体使用

```
// 装饰者 Mocha 的初始化方法初始化一个装饰器，beverage2 的实际类型是 Mocha（继承自 CondimentDecorator， 而它又继承自 Beverage），这时它内部的 _beverage 成员变量是上面异步初始化的 DarkRose
beverage2 = [[Mocha alloc] initWithBeverage:beverage2];
// 装饰者 Soy 的初始化方法初始化一个装饰器，beverage2 的实际类型是 Soy（继承自 CondimentDecorator， 而它又继承自 Beverage），这时它内部的 _beverage 成员变量是上面异步初始化的 Mocha
beverage2 = [[Soy alloc] initWithBeverage:beverage2];
// 装饰者 Whip 的初始化方法初始化一个装饰器，beverage2 的实际类型是 Whip（继承自 CondimentDecorator， 而它又继承自 Beverage），这时它内部的 _beverage 成员变量是上面异步初始化的 Soy
beverage2 = [[Whip alloc] initWithBeverage:beverage2];

// 现在 beverage2 的类型是 Whip， 因此该方法会先去调 Whip 的 getDescript， 而后是 Soy 的 getDescript，接着是 Mocha 的 getDescript 最后是 DarkRose 继承自父类的方法 getDescript 返回自己的成员变量 _descript， 它的值是 @"Dark Rose Coffee"
NSString *descript = [beverage2 getDescript];
// cost 方法的调用过程同上
CGFloat cost = [beverage2 cost];
NSLog(@"%@ $%.2f", descript, cost);
```
输出
```
2018-06-23 19:21:38.455855+0800 01-Beverage[15712:538948] Dark Rose Coffee, Mocha, Soy, Whip $1.44
```
