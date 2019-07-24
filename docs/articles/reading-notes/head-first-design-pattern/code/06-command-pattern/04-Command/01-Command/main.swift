//
//  main.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

//var livingRoomLight = Light(name: "Living Room")
//var kitchenLight = Light(name: "Kitchen Room")
//var garageDoor = GarageDoor(name: "GarageDoor")
//var stereo = Stereo(name: "Living Room")
//
//var livingEoomLightOn = LightOnCommand(light: livingRoomLight)
//var livingEoomLightOff = LightOffCommand(light: livingRoomLight)
//
//var kitchenLightOn = LightOnCommand(light: kitchenLight)
//var kitchenLightOff = LightOffCommand(light: kitchenLight)
//
//var garageDoorUp = GarageDoorUpCommand(garageDoor: garageDoor)
//var garageDoorDown = GarageDoorDownCommand(garageDoor: garageDoor)
//
//var stereoOnWithCD = StereoOnWithCDCommand(stereo: stereo)
//var stertoOff = StereOffCommand(stereo: stereo)
//
//var remoteControl = RemoteControl()
//
//remoteControl.setCommand(slot: 0, onCommand: livingEoomLightOn, offCommand: livingEoomLightOff)
//remoteControl.setCommand(slot: 1, onCommand: kitchenLightOn, offCommand: kitchenLightOff)
//remoteControl.setCommand(slot: 2, onCommand: garageDoorUp, offCommand: garageDoorDown)
//remoteControl.setCommand(slot: 3, onCommand: stereoOnWithCD, offCommand: stertoOff)
//
//remoteControl.onButtonWasPressed(solt: 0)
//remoteControl.offButtonWasPressed(solt: 0)
//remoteControl.onButtonWasPressed(solt: 1)
//remoteControl.offButtonWasPressed(solt: 1)
//remoteControl.onButtonWasPressed(solt: 2)
//remoteControl.offButtonWasPressed(solt: 2)
//remoteControl.onButtonWasPressed(solt: 3)
//remoteControl.offButtonWasPressed(solt: 3)

//var remoteControl = RemoteControl()
//
//var livingRoomLight = Light(name: "Living Room")
//
//var livingEoomLightOn = LightOnCommand(light: livingRoomLight)
//var livingEoomLightOff = LightOffCommand(light: livingRoomLight)
//
//remoteControl.setCommand(slot: 0, onCommand: livingEoomLightOn, offCommand: livingEoomLightOff)
//
//remoteControl.onButtonWasPressed(solt: 0)
//remoteControl.offButtonWasPressed(solt: 0)
//
//remoteControl.undoButtonWasPressed()
//
//remoteControl.offButtonWasPressed(solt: 0)
//remoteControl.onButtonWasPressed(solt: 0)
//
//remoteControl.undoButtonWasPressed()


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






