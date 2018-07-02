//
//  SimpleRemoteControl.swift
//  01-Command
//
//  Created by zhouke on 2018/7/2.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class SimpleRemoteControl {
    
    var solt: Command?
    
    func setCommand(commad: Command) {
        solt = commad
    }
    
    func bottomWasPressed() {
        solt?.execute()
    }
    
}
