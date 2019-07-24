//
//  LightOnCommand.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class LightOnCommand: Command {
    var light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.on()
    }
    
    func undo() {
        light.off()
    }
}
