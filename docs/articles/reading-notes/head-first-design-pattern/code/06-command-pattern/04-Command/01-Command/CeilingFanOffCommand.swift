//
//  CeilingFanOffCommand.swift
//  01-Command
//
//  Created by zhouke on 2018/7/4.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class CeilingFanOffCommand: Command {
    var ceilingFan: CeilingFan
    var prevSpeed: SpeedType = .Off
    
    init(ceilingFan: CeilingFan) {
        self.ceilingFan = ceilingFan
    }
    
    func execute() {
        prevSpeed = ceilingFan.getSpeed()
        ceilingFan.off()
    }
    
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
}
