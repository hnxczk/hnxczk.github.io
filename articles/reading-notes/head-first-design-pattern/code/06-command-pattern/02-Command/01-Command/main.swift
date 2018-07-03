//
//  main.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

var remote = SimpleRemoteControl()
var light = Light()
var lightOn = LightOnCommand(light: light)

remote.setCommand(commad: lightOn)
remote.bottomWasPressed()

var garage = Garage()
var garageDoorOpen = GarageDoorOpenCommand(garage: garage)

remote.setCommand(commad: garageDoorOpen)
remote.bottomWasPressed()
