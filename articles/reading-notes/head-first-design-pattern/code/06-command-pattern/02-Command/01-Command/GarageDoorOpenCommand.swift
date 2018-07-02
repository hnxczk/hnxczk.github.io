//
//  GarageDoorOpenCommand.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class GarageDoorOpenCommand: Command {
    var garage: Garage
    
    init(garage: Garage) {
        self.garage = garage
    }
    
    func execute() {
        self.garage.lightOn()
    }
    
}
