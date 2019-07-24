//
//  MazeGame.swift
//  01-creat-pattern
//
//  Created by zhouke on 2018/9/6.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class MazeGame {
    func creatMaze() -> Maze {
        let aMaze = Maze()
        let r1 = Room(roomNo: 1)
        let r2 = Room(roomNo: 2)
        let theDoor = Door(room1: r1, room2: r2)
        
        aMaze.addRoom(room: r1)
        aMaze.addRoom(room: r2)
        
        r1.setSide(direction: .North, mapSite: Wall())
        r1.setSide(direction: .East, mapSite: theDoor)
        r1.setSide(direction: .South, mapSite: Wall())
        r1.setSide(direction: .West, mapSite: Wall())
        
        r2.setSide(direction: .North, mapSite: Wall())
        r2.setSide(direction: .East, mapSite: Wall())
        r2.setSide(direction: .South, mapSite: Wall())
        r2.setSide(direction: .West, mapSite: theDoor)
        
        return aMaze;
    }
}
