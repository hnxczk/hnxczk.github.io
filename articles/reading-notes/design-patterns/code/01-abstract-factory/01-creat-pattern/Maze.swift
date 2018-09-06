//
//  Maze.swift
//  01-creat-pattern
//
//  Created by zhouke on 2018/9/6.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class Maze {
    
    var roomDict: [Int : Room] = [Int : Room]()
    
    func addRoom(room: Room) {
        roomDict[room.roomNumber] = room
    }
    
    func roomNo(number: Int) -> Room? {
        return roomDict[number]
    }
}
