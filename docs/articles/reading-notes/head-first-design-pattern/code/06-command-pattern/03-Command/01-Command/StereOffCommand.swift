//
//  StereOffCommand.swift
//  01-Command
//
//  Created by zhouke on 2018/7/3.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class StereOffCommand: Command {
    var stereo: Stereo
    
    init(stereo: Stereo) {
        self.stereo = stereo
    }
    
    func execute() {
        stereo.off()
    }
    
    func undo() {
        stereo.on()
    }
}
