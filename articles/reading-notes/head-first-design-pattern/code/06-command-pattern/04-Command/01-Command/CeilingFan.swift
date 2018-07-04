//
//  CeilingFan.swift
//  01-Command
//
//  Created by zhouke on 2018/7/4.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

enum SpeedType: Int {
    case Off = 0, Low, Medium, High
}

class CeilingFan: Appliance {
    
    var speed: SpeedType {
        didSet {
            print("\(name) speed is \(speed)")
        }
    }
    
    override init(name: String) {
        self.speed = .Off
        super.init(name: name)
    }
    
    func high() {
        speed = .High
    }
    
    func medium() {
        speed = .Medium
    }
    
    func low() {
        speed = .Low
    }
    
    func off() {
        speed = .Off
    }
    
    func getSpeed() -> SpeedType {
        return speed
    }
}
