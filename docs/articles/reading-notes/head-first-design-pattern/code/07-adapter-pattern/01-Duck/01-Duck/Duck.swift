//
//  Duck.swift
//  01-Duck
//
//  Created by zhouke on 2018/7/7.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

protocol Duck {
    func quack()
    func fly()
}

extension Duck {
    func quack() {
        print("Quack")
    }
    
    func fly() {
        print("I'm flying")
    }
}
