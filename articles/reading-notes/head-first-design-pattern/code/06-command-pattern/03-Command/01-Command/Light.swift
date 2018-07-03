//
//  Light.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class Light: Appliance {
    
    func on() {
        print("\(name) Light is on!")
    }
    
    func off() {
        print("\(name) Light is off!")
    }
}
