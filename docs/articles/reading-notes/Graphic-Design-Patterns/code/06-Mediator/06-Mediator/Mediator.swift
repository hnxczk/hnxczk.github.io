//
//  Mediator.swift
//  06-Mediator
//
//  Created by zhouke on 2018/11/1.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

protocol Mediator {
    func operation(nWho: Int, str: String)
    func registered(nWho: Int, colleague: Colleague)
}

class ConcreateMediator: Mediator {
    
    var colleagueMap = Dictionary<Int, Colleague>()
    
    func operation(nWho: Int, str: String) {
        let colleague = self.colleagueMap[nWho]
        if let colleague = colleague {
            colleague.receiveMsg(str: str)
        } else {
            print("not found this colleague!")
        }
    }
    
    func registered(nWho: Int, colleague: Colleague) {
        colleagueMap[nWho] = colleague
        colleague.mediator = self
    }
}
