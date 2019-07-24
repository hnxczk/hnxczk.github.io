//
//  ViewController.swift
//  08-Strategy
//
//  Created by zhouke on 2018/11/2.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let context = Context()
        
        let concreteStrategyA = ConcreteStrategyA()
        context.strategy = concreteStrategyA
        context.algorithm()
        
        let concreteStrategyB = ConcreteStrategyB()
        context.strategy = concreteStrategyB
        context.algorithm()
        
    }


}

