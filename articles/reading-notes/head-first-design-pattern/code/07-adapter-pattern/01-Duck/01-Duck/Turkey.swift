//
//  Turkey.swift
//  01-Duck
//
//  Created by zhouke on 2018/7/7.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

protocol Turkey {
    func gobble()
    func fly()
}

extension Turkey {
    func gobble() {
        print("Gobble gobble")
    }
    func fly() {
        print("I'm flying a short distance")
    }
}
