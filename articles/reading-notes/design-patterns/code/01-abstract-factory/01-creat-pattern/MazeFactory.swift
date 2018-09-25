//
//  MazeFactory.swift
//  01-creat-pattern
//
//  Created by zhouke on 2018/9/6.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class MazeFactory {
    func makeMaze() -> Maze {
        return Maze()
    }
    
    func makeMaze() -> Wall {
        return Wall()
    }
    
    func makeMaze(n: Int) -> Room {
        return Room(roomNo: n)
    }
    
    func makeMaze(room1: Room, room2: Room) -> Door {
        return Door(room1: room1, room2: room2)
    }
}
