//
//  ViewController.swift
//  07-State
//
//  Created by zhouke on 2018/11/2.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = Context(originalState: ConcreteStateA.share())
        
        context.request()
        context.request()
        context.request()
        
    }


}

