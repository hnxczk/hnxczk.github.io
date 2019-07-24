//
//  ViewController.swift
//  06-Mediator
//
//  Created by zhouke on 2018/11/1.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pm = ConcreateMediator()
        
        let pa = ConcreteColleagueA()
        pm.registered(nWho: 1, colleague: pa)
        
        let pb = ConcreteColleagueB()
        pm.registered(nWho: 2, colleague: pb)
        
        pa.sendMsg(toWho: 2, str: "hello, i am a")
        
        pb.sendMsg(toWho: 1, str: "hello, i am b")
        
        
    }
}

