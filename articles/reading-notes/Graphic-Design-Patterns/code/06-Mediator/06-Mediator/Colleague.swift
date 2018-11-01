//
//  Colleague.swift
//  06-Mediator
//
//  Created by zhouke on 2018/11/1.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

class Colleague {
    
    var mediator: Mediator?
    
    func receiveMsg(str: String) { }
    func sendMsg(toWho: Int, str: String) { }
}


class ConcreteColleagueA: Colleague {
    override func receiveMsg(str: String) {
        print("ConcreteColleagueA reveivemsg: \(str)")
    }
    
    override func sendMsg(toWho: Int, str: String) {
        print("send msg from colleagueA,to: \(toWho)")
        self.mediator?.operation(nWho: toWho, str: str)
    }
}

class ConcreteColleagueB: Colleague {
    override func receiveMsg(str: String) {
        print("ConcreteColleagueB reveivemsg: \(str)")
    }
    
    override func sendMsg(toWho: Int, str: String) {
        print("send msg from colleagueB,to: \(toWho)")
        self.mediator?.operation(nWho: toWho, str: str)
    }
}
