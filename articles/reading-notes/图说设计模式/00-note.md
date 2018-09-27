# 目录

图说设计模式是开源于 [GitBook](https://design-patterns.readthedocs.io/zh_CN/latest/index.html) 上的一本介绍设计模式的书，比较了多个介绍设计模式的书之后感觉这本书的介绍更符个人的理解方式。因此在这里记录一下看书过程。

## 看懂 UML 类图和时序图

见 [这里](../uml.md)

## 创建型模式

创建型模式(Creational Pattern)对类的实例化过程进行了抽象，能够将软件模块中对象的创建和对象的使用分离。为了使软件的结构更加清晰，外界对于这些对象只需要知道它们共同的接口，而不清楚其具体的实现细节，使整个系统的设计更加符合单一职责原则。

### 1. 简单工厂
简单工厂又称为静态工厂方法模式。

个人感觉这种设计模式就是一个封装思想的体现，比如在我们做界面的时候有两个不同的 Button，一种是文字图片左右布局，一种是文字图片上下布局。这时候我们常见的封装思路就是为 UIButton 添加一个分类，为其添加一个构建不同按钮的方法。显然这个方法可以是一个类方法（也就是其他语言中的静态方法），而且这个方法需要接收一个参数来区分要创建哪种按钮，可以是字符串或者最好的是一个枚举类型。

这样以来其实就构成了一个简单工厂模式的典型例子。其中这个 UIButton 的分类就是一个工厂的角色，两种类型的 Button 就是具体产品角色。 他们的父类 UIButton 就是抽象产品的角色。

![](./images/SimpleFactory.jpg)

```
extension UIButton {
    static func adjustedBtn(type: ButtonType) -> UIButton {
        switch type {
        case .leftAndRight:
            let button = UIButton()
            button.setTitle("leftAndRight", for: .normal)
            return button
        case .topAndBottom :
            let button = UIButton()
            button.setTitle("topAndBottom", for: .normal)
            return button
        }
    }
}
```

简单工厂模式的要点在于：当你需要什么，只需要传入一个正确的参数，就可以获取你所需要的对象，而无须知道其创建细节。

优点：简化使用者的工作，封装创建的代码便于复用。

缺点：添加新的产品时需要修改工厂逻辑，不便于维护和扩展。

### 2. 工厂方法

工厂方法模式是简单工厂模式的进一步抽象和推广。由于使用了面向对象的多态性，工厂父类负责定义创建产品对象的公共接口，而工厂子类则负责生成具体的产品对象，这样做的目的是将产品类的实例化操作延迟到工厂子类中完成，即通过工厂子类来确定究竟应该实例化哪一个具体产品类。这使得工厂方法模式可以允许系统在不修改工厂角色的情况下引进新产品。

![](./images/FactoryMethod.jpg)

工厂方法通过抽象的父类来实现更高的拓展性，这也是抽象威力的一种体现。简单来说就是通过抽象就可以让使用者不再关心具体类型，而只需要关心具体类型的抽象父类的提供接口就行了。

一个简单的例子就是我们在写业务代码的时候往往会出现在一个页面根据条件跳转到另外几个不同的界面，比如现在有两个按钮每个按钮跳转的的界面不同，但是都是控制器。这时候通过工厂方法来声明一个抽象的工厂类 AbstractFactory，然后生成两个具体工程类 FactoryA 和 FactoryB 继承自 AbstractFactory。这时候的跳转逻辑可以改成下面的代码。

```
@IBAction func leftClick() {
        self.factory = FactoryA()
        self.pushWithFactory()
    }
    
    @IBAction func rightClick() {
        self.factory = FactoryB()
        self.pushWithFactory()
    }
    
    func pushWithFactory() {
        let vc = self.factory?.creatController()
        if let vc = vc {
            self.present(vc, animated: true, completion: nil)
        }
    }
```

初看这个方法也没什么优点，还多创建了工厂类族。但是当添加新的跳转逻辑的时候这个模式的威力就体现了出来。

```
@IBAction func middleClick() {
        self.factory = FactoryC()
        self.pushWithFactory()
    }
```

可以看出来只需要新建新的具体工厂 FactoryC 和控制器 ControllerC 就可以了，不需要修改其他跳转的逻辑。

> 使用工厂方法模式的另一个优点是在系统中加入新产品时，无须修改抽象工厂和抽象产品提供的接口，无须修改客户端，也无须修改其他的具体工厂和具体产品，而只要添加一个具体工厂和具体产品就可以了。这样，系统的可扩展性也就变得非常好，完全符合“开闭原则”。

这个就是工厂方法使用情景。
### 3. 抽象工厂
了解之前首先明确两个概念

> 产品等级结构 ：产品等级结构即产品的继承结构，如一个抽象类是电视机，其子类有海尔电视机、海信电视机、TCL电视机，则抽象电视机与具体品牌的电视机之间构成了一个产品等级结构，抽象电视机是父类，而具体品牌的电视机是其子类。

> 产品族 ：在抽象工厂模式中，产品族是指由同一个工厂生产的，位于不同产品等级结构中的一组产品，如海尔电器工厂生产的海尔电视机、海尔电冰箱，海尔电视机位于电视机产品等级结构中，海尔电冰箱位于电冰箱产品等级结构中。

多个位于不同产品等级结构中属于不同类型的具体产品时需要使用抽象工厂模式.


![](./images/AbatractFactory.jpg)

当一个产品族中的多个对象被设计成一起工作时，它能够保证客户端始终只使用同一个产品族中的对象。这对一些需要根据当前环境来决定其行为的软件系统来说，是一种非常实用的设计模式。

### 4. 建造者模式
建造者模式主要用于复杂对象的创建。比如一个对象由多个对象组合而成，但是他们的赋值过程需要按照一定的顺序来进行。这时候就需要使用建造者模式了。

![](./images/Builder.jpg)

其中最总要的角色就是 Director 。 所有的建造过程都是由他进行控制的。

当然在实际的使用中可以省略掉一些角色。
- 省略抽象建造者角色：如果系统中只需要一个具体建造者的话，可以省略掉抽象建造者。
- 省略指挥者角色：在具体建造者只有一个的情况下，如果抽象建造者角色已经被省略掉，那么还可以省略指挥者角色，让 Builder 角色扮演指挥者与建造者双重角色。

在实际的使用中，我认为上面的角色都可以省略掉，由产品自己来提供创建方法。

```
- (instancetype)initWithTitle:(NSString *)title
                 contentImage:(NSString *)contentImage
                   customView:(UIView *)customView
                      message:(NSString *)message
            attributedMessage:(NSAttributedString *)attributedMessage
                messageDetail:(NSString *)messageDetail
      attributedMessageDetail:(NSAttributedString *)attributedMessageDetail
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
{
    ...

    if (title.length) {
        self.title = title;
        [self.centerBackView addSubview:self.titleLab];
    }
        
    [self.centerBackView addSubview:self.contentScrollView];
        
    if (contentImage) {
        self.contentImage = contentImage;
        [self.contentScrollView addSubview:self.contentImageView];
    }

    ...
}
```
比如上面这个方法是我之前封装的一个自定义弹框的控件。我提供了一个初始化方法，当然 title 和 contentImage 可能会传空，这时候这个方法就会判断传入的值来添加相应的视图。这个时候这个初始化方法就是一个指挥者的角色。

与抽象工厂模式相比， 建造者模式返回一个组装好的完整产品 ，而 抽象工厂模式返回一系列相关的产品，这些产品位于不同的产品等级结构，构成了一个产品族。

### 5. 单例模式

## 结构型模式
## 行为型模式