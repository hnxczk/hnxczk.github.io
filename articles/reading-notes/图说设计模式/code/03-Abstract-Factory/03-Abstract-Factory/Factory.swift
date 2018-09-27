//
//  Factory.swift
//  03-Abstract-Factory
//
//  Created by zhouke on 2018/9/26.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Cocoa

protocol Factory {
    func creatProductA() -> ProductA
    func creatProductB() -> ProductB
}

class Factory1: Factory {
    func creatProductA() -> ProductA {
        return ProductA1()
    }
    
    func creatProductB() -> ProductB {
        return ProductB1()
    }
}

class Factory2: Factory {
    func creatProductA() -> ProductA {
        return ProductA2()
    }
    
    func creatProductB() -> ProductB {
        return ProductB2()
    }
}


