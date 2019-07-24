//
//  Stereo.swift
//  01-Command
//
//  Created by zhouke on 2018/7/3.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class Stereo: Appliance {
    func on() {
        print("\(name) stereo on")
    }
    
    func off() {
        print("\(name) stereo off")
    }
    
    func setCD() {
        print("\(name) stereo set for CD input")
    }
    
    func setDVD() {
        print("\(name) stereo set for DVD input")
    }
    
    func setRadio() {
        print("\(name) stereo set for redio")
    }
    
    func setVolume() {
        print("\(name) stereo set volume")
    }
}
