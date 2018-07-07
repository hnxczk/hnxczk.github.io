//
//  TurkeyAdapter.swift
//  01-Duck
//
//  Created by zhouke on 2018/7/7.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class TurkeyAdapter: Duck {
    var turkey: Turkey
    
    init(turkey: Turkey) {
        self.turkey = turkey
    }
    
    func quack() {
        turkey.gobble()
    }
    
    // 由于火鸡飞的近因此调用多次的飞行
    func fly() {
        for _ in 0..<5 {
            turkey.fly()
        }
    }
}
