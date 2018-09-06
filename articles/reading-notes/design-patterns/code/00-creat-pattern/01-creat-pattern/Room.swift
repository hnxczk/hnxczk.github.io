//
//  Room.swift
//  01-creat-pattern
//
//  Created by zhouke on 2018/9/6.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class Room: MapSite {
    
    var roomNumber: Int
    
    var sides: [MapSite]?
    
    init(roomNo: Int) {
        self.roomNumber = roomNo
    }
    
    func getSide(direction: Direction) -> MapSite? {
        return nil;
    }
    
    func setSide(direction: Direction, mapSite: MapSite) {

    }
    
    override func enter() {
        
    }
}
