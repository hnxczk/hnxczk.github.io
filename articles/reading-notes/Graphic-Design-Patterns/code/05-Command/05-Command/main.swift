//
//  main.swift
//  05-Command
//
//  Created by zhouke on 2018/10/31.
//  Copyright © 2018 zhouke. All rights reserved.
//

import Foundation

let receiver = Receiver()
let command = ConcreteCommand(receiver: receiver)
let invoker = Invoker(command: command)
invoker.call()

