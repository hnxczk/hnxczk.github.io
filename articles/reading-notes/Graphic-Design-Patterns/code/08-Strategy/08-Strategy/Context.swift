//
//  Context.swift
//  08-Strategy
//
//  Created by zhouke on 2018/11/2.
//  Copyright © 2018 zhouke. All rights reserved.
//

import UIKit

class Context {
    var strategy: Strategy?
    
    func algorithm() {
        self.strategy?.algorithm()
    }
}
