//
//  Garage.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class GarageDoor: Appliance {
    
    func up() {
        print("\(name) door up!")
    }
    
    func down() {
        print("\(name) door down!")
    }
    
    func stop() {
        
    }
    
    func lightOn() {
        print("Garage light on!")
    }
    
    func lightOff() {
        
    }
}
