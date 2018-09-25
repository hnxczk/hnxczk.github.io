//
//  Door.swift
//  01-creat-pattern
//
//  Created by zhouke on 2018/9/6.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class Door: MapSite {
    var room1: Room
    var room2: Room
    var isOpen: Bool = false
    
    init(room1: Room, room2: Room) {
        self.room1 = room1
        self.room2 = room2
    }
    
    func otherSideFrom(room: Room) -> Room? {
        return nil;
    }
    
    override func enter() {
        
    }
    
}
