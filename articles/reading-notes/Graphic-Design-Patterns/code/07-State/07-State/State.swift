//
//  State.swift
//  07-State
//
//  Created by zhouke on 2018/11/2.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

protocol State {
    
    static func share() -> State
    func handle(context: Context)
    
}

class ConcreteStateA: State {
    
    private static let instance = ConcreteStateA()
    
    static func share() -> State {
        return instance
    }
    
    func handle(context: Context) {
        print("doing something in State A.")
        context.changeState(state: ConcreteStateB.share())
    }
    
}

class ConcreteStateB: State {
    
    private static let instance = ConcreteStateB()
    
    static func share() -> State {
        return instance
    }
    
    func handle(context: Context) {
        print("doing something in State B.")
        context.changeState(state: ConcreteStateA.share())
    }
    
}
