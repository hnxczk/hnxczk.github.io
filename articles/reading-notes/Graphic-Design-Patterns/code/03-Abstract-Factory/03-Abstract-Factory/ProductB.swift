//
//  ProductB.swift
//  03-Abstract-Factory
//
//  Created by zhouke on 2018/9/26.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Cocoa

protocol ProductB {
    func run()
}

class ProductB1: ProductB {
    func run() {
        print("ProductB1")
    }
}

class ProductB2: ProductB {
    func run() {
        print("ProductB2")
    }
}
