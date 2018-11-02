//
//  Context.swift
//  07-State
//
//  Created by zhouke on 2018/11/2.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

class Context {
    var state: State
    
    init(originalState: State) {
        self.state = originalState
    }
    
    func changeState(state: State) {
        print("change state to \(state)")
        self.state = state
    }
    
    func request() {
        self.state.handle(context: self)
    }
}
