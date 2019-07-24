//
//  FlyWeight.swift
//  04-Flyweight
//
//  Created by zhouke on 2018/10/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Foundation

protocol FlyWeight {
    func action()
}


class ConcreteFlyWeight: FlyWeight {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func action() {
        print("name = \(self.name) action")
    }
    
}
