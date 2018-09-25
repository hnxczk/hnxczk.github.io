//
//  MazeGame.swift
//  01-creat-pattern
//
//  Created by zhouke on 2018/9/6.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Cocoa

class MazeGame {
    func creatMaze(factory: MazeFactory) -> Maze {
        let aMaze: Maze = factory.makeMaze()
        let r1 = factory.makeMaze(n: 1)
        let r2 = factory.makeMaze(n: 2)
        let theDoor = factory.makeMaze(room1: r1, room2: r1)
        
        aMaze.addRoom(room: r1)
        aMaze.addRoom(room: r2)
        
        r1.setSide(direction: .North, mapSite: factory.makeMaze())
        r1.setSide(direction: .East, mapSite: theDoor)
        r1.setSide(direction: .South, mapSite: factory.makeMaze())
        r1.setSide(direction: .West, mapSite: factory.makeMaze())
        
        r2.setSide(direction: .North, mapSite: factory.makeMaze())
        r2.setSide(direction: .East, mapSite: factory.makeMaze())
        r2.setSide(direction: .South, mapSite: factory.makeMaze())
        r2.setSide(direction: .West, mapSite: theDoor)
        
        return aMaze;
    }
}
