//
//  Factory.swift
//  02-factory-method
//
//  Created by zhouke on 2018/9/9.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import UIKit

protocol AbstractFactory {
    func creatController() -> UIViewController
}

class FactoryA: AbstractFactory {
    func creatController() -> UIViewController {
        return ControllerA()
    }
}

class FactoryB: AbstractFactory {
    func creatController() -> UIViewController {
        return ControllerB()
    }
}

class FactoryC: AbstractFactory {
    func creatController() -> UIViewController {
        return ControllerC()
    }
}
