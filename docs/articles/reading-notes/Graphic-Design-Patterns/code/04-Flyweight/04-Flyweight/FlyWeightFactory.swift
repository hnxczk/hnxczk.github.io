//
//  FlyWeightFactory.swift
//  04-Flyweight
//
//  Created by zhouke on 2018/10/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Foundation

class FlyWeightFactory {
    var concurrentHashMap = {() -> Dictionary<String, FlyWeight> in
        return Dictionary()
    }()
    
    func getFlyweight(name: String) -> FlyWeight {
        let flyweight = self.concurrentHashMap[name]
        
        if let flyweight = flyweight {
            print("Instance of name = \(name) exist")
            return flyweight
        } else {
            print("Instance of name = \(name) does not exist, creating it")
            let flyweight = ConcreteFlyWeight(name: name)
            print("Instance of name = \(name) created")
            self.concurrentHashMap[name] = flyweight
            return flyweight
        }
        
    }
}
