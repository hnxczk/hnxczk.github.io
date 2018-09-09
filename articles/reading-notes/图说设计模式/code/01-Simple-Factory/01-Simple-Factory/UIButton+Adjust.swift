//
//  UIButton+Adjust.swift
//  01-Simple-Factory
//
//  Created by zhouke on 2018/9/9.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import UIKit

enum ButtonType {
    case leftAndRight, topAndBottom
}

extension UIButton {
    static func adjustedBtn(type: ButtonType) -> UIButton {
        switch type {
        case .leftAndRight:
            let button = UIButton()
            button.setTitle("leftAndRight", for: .normal)
            return button
        case .topAndBottom :
            let button = UIButton()
            button.setTitle("topAndBottom", for: .normal)
            return button
        }
    }
}
