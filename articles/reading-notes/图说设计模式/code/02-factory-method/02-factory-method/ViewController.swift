//
//  ViewController.swift
//  02-factory-method
//
//  Created by zhouke on 2018/9/9.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var factory: AbstractFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func leftClick() {
        self.factory = FactoryA()
        self.pushWithFactory()
    }
    
    @IBAction func rightClick() {
        self.factory = FactoryB()
        self.pushWithFactory()
    }
    
    @IBAction func middleClick() {
        self.factory = FactoryC()
        self.pushWithFactory()
    }
    
    func pushWithFactory() {
        let vc = self.factory?.creatController()
        if let vc = vc {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

