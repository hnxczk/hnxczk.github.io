//
//  main.swift
//  03-Abstract-Factory
//
//  Created by zhouke on 2018/9/26.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Foundation

func useProduct(factory: Factory) {
    let productA = factory.creatProductA()
    let productB = factory.creatProductB()
    productA.use()
    productB.run()
}

let factory1 = Factory1()
useProduct(factory: factory1)

let factory2 = Factory2()
useProduct(factory: factory2)

