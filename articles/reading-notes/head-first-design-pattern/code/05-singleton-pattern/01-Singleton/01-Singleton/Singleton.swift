//
//  Singleton.swift
//  01-Singleton
//
//  Created by zhouke on 2018/6/25.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation

class Singleton {
    private static var instance: Singleton?

    private init() {}
    
    static func share() -> Singleton {
        if instance == nil {
            instance = Singleton()
        }
        return instance!
    }
    
    // other method
}
