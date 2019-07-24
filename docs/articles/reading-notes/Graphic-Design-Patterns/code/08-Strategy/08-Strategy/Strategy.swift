//
//  Strategy.swift
//  08-Strategy
//
//  Created by zhouke on 2018/11/2.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

protocol Strategy {
    func algorithm()
}

class ConcreteStrategyA: Strategy {
    func algorithm() {
        print("ConcreteStrategyA")
    }
}

class ConcreteStrategyB: Strategy {
    func algorithm() {
        print("ConcreteStrategyB")
    }
}

