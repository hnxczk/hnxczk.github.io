//
//  ChocolateBoiler2.swift
//  01-Singleton
//
//  Created by zhouke on 2018/6/25.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class ChocolateBoiler2 {
    private var empty: Bool
    private var boiled: Bool
    
    private static let instance = ChocolateBoiler2()
    
    private init() {
        empty = true;
        boiled = false;
    }
    
    static func share() -> ChocolateBoiler2 {
        return instance
    }
    
    func fill() {
        // 空的才能往里加入原料
        if isEmpty() {
            empty = false
            boiled = false
        }
    }
    
    func drain() {
        // 必须是满的而且煮过的才能排出
        if !isEmpty() && isBoiled() {
            empty = true
        }
    }
    
    func boil() {
        // 煮的时候必须是满的并且没煮过的
        if !isEmpty() && !isBoiled() {
            boiled = true
        }
    }
    
    func isEmpty() -> Bool {
        return self.empty
    }
    
    func isBoiled() -> Bool {
        return self.boiled;
    }
}
