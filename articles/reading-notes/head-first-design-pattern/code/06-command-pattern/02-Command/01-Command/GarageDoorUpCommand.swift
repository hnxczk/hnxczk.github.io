//
//  GarageDoorUpCommand.swift
//  01-Command
//
//  Created by zhouke on 2018/7/3.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class GarageDoorUpCommand: Command {
    var garageDoor: GarageDoor
    
    init(garageDoor: GarageDoor) {
        self.garageDoor = garageDoor
    }
    
    func execute() {
        garageDoor.up()
    }
}
