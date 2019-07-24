//
//  RemoteControl.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class RemoteControl {
    var onCommands: [Command]
    var offCommands: [Command]
    
    init() {
        self.onCommands = [Command]()
        self.offCommands = [Command]()
        
        let noCommand = NoCommand()
        for _ in 0..<7 {
            self.onCommands.append(noCommand)
            self.offCommands.append(noCommand)
        }
    }
    
    func setCommand(slot:Int, onCommand: Command, offCommand: Command) {
        self.onCommands[slot] = onCommand
        self.offCommands[slot] = offCommand
    }
    
    func onButtonWasPressed(solt: Int) {
        self.onCommands[solt].execute()
    }
    
    func offButtonWasPressed(solt: Int) {
        self.offCommands[solt].execute()
    }
    
    func toString() {
        
    }
}
