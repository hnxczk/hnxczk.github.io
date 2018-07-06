# 命令模式
一个餐厅点餐的交互过程
1. 客户创建订单
2. 订单封装了准备餐点的请求
3. 女招待的工作是接受订单，然后调用订单的 orderUp() 方法
4. 厨师具备具体准备餐点的能力
![](./images/06-command-pattern-1.png)

抽象出来命令模式
![](./images/06-command-pattern-2.png)

具体代码见[这里](./code/06-command-pattern/01-Command)

## 定义命令模式
命令模式：将“请求”封装成对象，一边使用不同的请求、队列或者日志来来参数化其他对象。命令模式也支持可撤销的操作。

我们知道一个命令对象通过在特定接收者上绑定一组动作来封装一个请求。要达到这点，命令对象间动作和接收者包进对象中，这个对象只暴露出一个execute()方法，当此方法被调用的时候，接收者就会进行这些动作，从外面来看，其他对象不知道究竟哪个接收者进行了那些动作，只知道如果调动execute()方法，请求的目的就能达到。

![](./images/06-command-pattern-3.png)

## 实现遥控器
具体代码见[这里](./code/06-command-pattern/02-Command)

简单来说就是在 RemoteControl 类中通过数组来作为各种命令的容器，然后在执行命令的时候通过方法 `    func setCommand(slot:Int, onCommand: Command, offCommand: Command) `来设置。

![](./images/06-command-pattern-4.png)

## 使用状态撤销

在 CeilingFanHighCommand 的 undo 方法中添加以下代码

```
    var prevSpeed: SpeedType = .Off
```
使用 prevSpeed 来记录上次的 speed

```
    func undo() {
        switch prevSpeed {
        case .High:
            ceilingFan.high()
        case .Medium:
            ceilingFan.medium()
        case .Low:
            ceilingFan.low()
        case .Off:
            ceilingFan.off()
        }
    }
```
然后在 undo 方法中通过上次记录的 prevSpeed 来还原上次的操作。

```
var remoteControl = RemoteControl()

var ceilingFan = CeilingFan(name: "Living Room")

var ceilingFanHighCommand = CeilingFanHighCommand(ceilingFan: ceilingFan)
var ceilingFanMdeiomCommand = CeilingFanMediumCommand(ceilingFan: ceilingFan)
var ceilingFanOffCommand = CeilingFanOffCommand(ceilingFan: ceilingFan)

remoteControl.setCommand(slot: 0, onCommand: ceilingFanHighCommand, offCommand: ceilingFanOffCommand)
remoteControl.setCommand(slot: 1, onCommand: ceilingFanMdeiomCommand, offCommand: ceilingFanOffCommand)

// 点击第一行的 on 开关，remoteControl 的成员变量 undoCommand 会记录下 ceilingFanHighCommand，ceilingFanHighCommand 的 prevSpeed 会先记录下之前的 speed: off,然后调用 ceilingFan 的 high
remoteControl.onButtonWasPressed(solt: 0)
// 点击第一行的 off 开关，remoteControl 的成员变量 undoCommand 会记录下 ceilingFanOffCommand，ceilingFanOffCommand 的 prevSpeed 会记录下之前的speed： high， 然后调用 ceilingFan 的 off
remoteControl.offButtonWasPressed(solt: 0)
// 点击撤销时remoteControl 的成员变量 undoCommand 是 ceilingFanOffCommand，因此 调用 ceilingFanOffCommand 的 undo 根据之前记录下的 prevSpeed：high， 然后执行 high
remoteControl.undoButtonWasPressed()

remoteControl.onButtonWasPressed(solt: 1)
remoteControl.undoButtonWasPressed()
```

## 命令模式的其他用途
### 队列请求
命令可以将运算块打包(一个接受者和一组动作)，然后将它传来传去，就像是一般的对象一样，现在，即使在命令对象被创建许久之后，运算依然可以被调用，事实上，它甚至可以在不同的线程中被调用，我们可以利用这样的特性衍生一些应用，例如：日程安排，线程池，工作队列等。

想象有一个工作队列：你在某一端添加命令，然后另一端则是线程，线程进行下面的动作：从队列中取出一个命令，调用它的execute()方法，等待这个调用完成，然后将此命令对象丢弃，再取出下一个命令……

### 日志请求
更多应用需要我们将所有的动作都记录在日志中，并能在系统死机后，重新调用这些动作恢复到之前的状态。当我们执行命令的时候，将历时记录存储在磁盘中。一旦系统死机，我们就可以将命令对象重新加载，并成批地依次调用这些对象的execute()方法。

## 命令模式的思考 🤔
个人感觉 OC 中的 Block 和 Swift 中的 闭包，都可以看成是一组命令，也是命令模式的一种实现。比如 A 控制 push 出 B 控制器的时候，A 可以通过给 B 的一个 Block 属性赋值，把一些操作封装成命令传给 B，这样的话 比如 B 控制器内某个按钮点击后就可以通过调用 Block 属性来执行 A 传过来的命令，而不必关心具体的命令是什么。

