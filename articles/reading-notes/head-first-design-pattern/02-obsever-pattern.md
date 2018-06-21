# 观察者模式

## 定义

**观察者模式定义了对象之间的一对多依赖，这样一来，当一个对象改变状态时，它的所有依赖者都会受到通知并自动更新**

## 气象监测应用
建立一个应用，利用已知的 WeatherData 对象获取数据并更新三个布告板：目前情况（温度、湿度、气压）、气象统计、天气预报。

```
@interface WeatherData : NSObject

- (CGFloat)getTemperature;
- (CGFloat)getHumidity;
- (CGFloat)getPressure;

// 一旦气象测量更新，此方法会被调用
- (void)measurementsChanged;

@end
```
### 已知条件
1. WeatherData类具有getter方法，可以取得三个测量值。
2. 当心的测量数据备妥时，measurementsChanged 方法就会被调用（我们不在乎此方法是如何被调用的，我们只在乎它被调用了）。
3. 我们需要实现三个使用天气数据的布告板，一旦 WeatherData 有新的测量，这些布告板必须马上更新。
4. 此系统必须可扩展，让其他开发人员建立定制的布告板，用户可以随心所欲地添加或删除任何布告板。

## 错误示范

```
- (void)measurementsChanged
{
    CGFloat temp = [self getTemperature];
    CGFloat hum = [self getHumidity];
    CGFloat pressure = [self getPressure];
    
    [currentConditionsDisplay updateWithTemp:temp humidity:hum pressure:pressure];
    [statisticsDisplay updateWithTemp:temp humidity:hum pressure:pressure];
    [forecastDisplay updateWithTemp:temp humidity:hum pressure:pressure];
}
```
存在的问题
1. 我们是针对具体实现编程，而非针对接口。这样的话我们以后再正价或者删除布告板的时候必须修改程序。
2. 对于每个新的布告板，我们都得修改代码。
3. 我们无法再运行时动态地增加（或删除）布告板。
4. 我们尚未封装改变的部分。

## 观察者模式
定义

**观察者模式定义了对象之间的一对多依赖，这样一来，当一个对象改变状态时，它的所有依赖者都会受到通知并自动更新**

![](./images/02-obsver-pattern-1.png)

## 松耦合的威力

**松耦合的设计之所以能让我买建立有弹性的、能应对变化的系统是因为对象之间的画像依赖降到了最低。**

就拿观察者模式来说这就是一个松耦合的设计。主题只知道观察者实现了某些接口，但是它并不知道观察者具体的类型，也不知道观察者的具体细节。主题唯一依赖的就是一个实现相应接口的对象列表，把观察者加入该列表或者从列表中删除都不会影响到主题。

##代码实现

![](./images/02-obsever-pattern-2.png)

具体实现见[相关代码](./code/02-obsever-pattern/01-Weather)

## 观察者模式是怎么准守设计准则的

### 1. 找出程序中会变化的部分，然后将其和固定不变的部分分离
在观察者模式中，会改变的是主题的状态以及观察者的数量和类型。使用这个模式可以改变依赖于主题状态改变的对象，而不用改变主题。

### 2. 针对接口编程，不针对实现编程
主题与接口都使用接口，观察者利用主题的接口向主题注册，主题利用观察者接口通知观察者。这样就具有松耦合的优点。

### 3 多用组合，少用继承
观察者模式利用组合奖许多的观察者组合进祖逖的容器中。这样一来对象之间就没有继承而是通过组合产生关系。

## OC 中的观察者模式

### NSNotification

先看一个例子
```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeAction) name:NOTIFICATION_NAME object:nil];
}

- (void)noticeAction
{
    NSLog(@"getNotice");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME object:nil userInfo:nil];
}
```

在 iOS 中主题是由一个单例 `NSNotificationCenter` 来充当。 而一个观察者通过调用 `addObserver...` 方法来注册。与上面介绍的不同的是注的时候 OC 同时传入 selector 来告诉主题在通知观察者的时候的调用方法。这其实与通过协议的方式异曲同工。

### KVO

```
@interface ViewController ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@", change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.count = 10;
}

@end
```

```
2018-06-21 22:21:45.894083+0800 03-KVO[7403:124006] {
    kind = 1;
    new = 10;
    old = 0;
}
```

对于上面 KVO 的例子来说，self 即是主题也是观察者（当然很多情况下都不是这样，偷懒ing...），而 `observeValueForKeyPath...` 这个方法从当了协议的角色。

### 更多 OC 中二者的具体用法可以看南峰子大神的博客

1. [Foundation: NSKeyValueObserving(KVO)](http://southpeak.github.io/2015/04/23/cocoa-foundation-nskeyvalueobserving/)
2. [Foundation: NSNotificationCenter](http://southpeak.github.io/2015/03/20/cocoa-foundation-nsnotificationcenter/)