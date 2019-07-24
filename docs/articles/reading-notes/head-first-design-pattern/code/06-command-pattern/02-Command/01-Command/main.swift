//
//  main.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

var livingRoomLight = Light(name: "Living Room")
var kitchenLight = Light(name: "Kitchen Room")
var garageDoor = GarageDoor(name: "GarageDoor")
var stereo = Stereo(name: "Living Room")

var livingEoomLightOn = LightOnCommand(light: livingRoomLight)
var livingEoomLightOff = LightOffCommand(light: livingRoomLight)

var kitchenLightOn = LightOnCommand(light: kitchenLight)
var kitchenLightOff = LightOffCommand(light: kitchenLight)

var garageDoorUp = GarageDoorUpCommand(garageDoor: garageDoor)
var garageDoorDown = GarageDoorDownCommand(garageDoor: garageDoor)

var stereoOnWithCD = StereoOnWithCDCommand(stereo: stereo)
var stertoOff = StereOffCommand(stereo: stereo)

var remoteControl = RemoteControl()

remoteControl.setCommand(slot: 0, onCommand: livingEoomLightOn, offCommand: livingEoomLightOff)
remoteControl.setCommand(slot: 1, onCommand: kitchenLightOn, offCommand: kitchenLightOff)
remoteControl.setCommand(slot: 2, onCommand: garageDoorUp, offCommand: garageDoorDown)
remoteControl.setCommand(slot: 3, onCommand: stereoOnWithCD, offCommand: stertoOff)

remoteControl.onButtonWasPressed(solt: 0)
remoteControl.offButtonWasPressed(solt: 0)
remoteControl.onButtonWasPressed(solt: 1)
remoteControl.offButtonWasPressed(solt: 1)
remoteControl.onButtonWasPressed(solt: 2)
remoteControl.offButtonWasPressed(solt: 2)
remoteControl.onButtonWasPressed(solt: 3)
remoteControl.offButtonWasPressed(solt: 3)





