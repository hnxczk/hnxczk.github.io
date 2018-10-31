//
//  Command.swift
//  05-Command
//
//  Created by zhouke on 2018/10/31.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Cocoa

protocol Command {
    func execute()
}

class ConcreteCommand: Command {
    var receiver: Receiver
    
    init(receiver: Receiver) {
        self.receiver = receiver
    }
    
    func execute() {
        print("ConcreteCommand execute")
        self.receiver.action()
    }
}
