//
//  LightOffCommand.swift
//  01-Command
//
//  Created by zhouke on 2018/7/3.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class LightOffCommand: Command {
    var light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.off()
    }
    
    func undo() {
        light.on()
    }
}
