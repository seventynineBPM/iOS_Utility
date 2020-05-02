//
//  SlideMenuOptions.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/05/01.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

struct SlideMenuOption {
    var viewLength: CGFloat = CGFloat(UIUtils.getScreenWidth() * 0.8)
    var animateDulation: Double = 0.4
    var direction: SlideMenuDirection = .fromLeftToRight
    var backgroundColor: UIColor = .clear
    
    init() {
        
    }
    
    init(viewLength: CGFloat = CGFloat(UIUtils.getScreenWidth() * 0.8),
         animateDulation: Double = 0.4,
         direction: SlideMenuDirection = .fromLeftToRight,
         backgroundColor: UIColor = .clear) {
        
        self.viewLength = viewLength
        self.animateDulation = animateDulation
        self.direction = direction
        self.backgroundColor = backgroundColor
    }
}

enum SlideMenuDirection: Int {
    case fromLeftToRight = 1
    case fromRightToLeft = 2
    case fromBottomToTop = 3
    case fromTopToBottom = 4
    
    func getViewController() -> SlideMenuViewController {
        switch self {
        case .fromLeftToRight:
            return LeftMenuViewController()
        case .fromRightToLeft:
            return RightMenuViewController()
        case .fromBottomToTop:
            return BottomMenuViewController()
        case .fromTopToBottom:
            return TopMenuViewController()
        }
    }
}
