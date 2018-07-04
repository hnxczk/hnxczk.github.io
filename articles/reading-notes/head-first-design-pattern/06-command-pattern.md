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

