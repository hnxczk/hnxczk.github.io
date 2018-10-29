//
//  ProductA.swift
//  03-Abstract-Factory
//
//  Created by zhouke on 2018/9/26.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Cocoa

protocol ProductA {
    func use()
}

class ProductA1: ProductA {
    func use() {
        print("ProductA1")
    }
}

class ProductA2: ProductA {
    func use() {
        print("ProductA2")
    }
}
