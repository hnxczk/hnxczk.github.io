//
//  ViewController.swift
//  04-Flyweight
//
//  Created by zhouke on 2018/10/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory = FlyWeightFactory()
        let fw = factory.getFlyweight(name: "one")
        fw.action()
        
        let fw1 = factory.getFlyweight(name: "two")
        fw1.action()
        
        let fw2 = factory.getFlyweight(name: "one")
        fw2.action()
    }


}

