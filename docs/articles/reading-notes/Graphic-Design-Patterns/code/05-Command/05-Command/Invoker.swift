//
//  Invoker.swift
//  05-Command
//
//  Created by zhouke on 2018/10/31.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Cocoa

class Invoker {
    var command: Command
    
    init(command: Command) {
        self.command = command
    }
    
    func call() {
        print("Invoker call")
        self.command.execute()
    }
}
