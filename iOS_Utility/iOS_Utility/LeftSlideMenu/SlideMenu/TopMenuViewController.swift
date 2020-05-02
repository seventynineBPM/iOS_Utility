//
//  TopMenuViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/05/02.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class TopMenuViewController: SlideMenuViewController {

    override func initMenuView() {
        let menuView = UIView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.backgroundColor = .white
        self.view.addSubview(menuView)
        
        let leadingConst = NSLayoutConstraint.init(item: menuView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConst = NSLayoutConstraint.init(item: menuView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let trailingConst = NSLayoutConstraint.init(item: menuView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let heightConst = NSLayoutConstraint.init(item: menuView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: options.viewLength)

        self.view.addConstraints([leadingConst,bottomConst,trailingConst,heightConst])

        self.menuView = menuView
        self.menuViewBottomConst = bottomConst
    }
    
    override func moveMenuView(moveDistance: CGFloat, show: Bool, duration: TimeInterval) {
        let movement: CGFloat = CGFloat(show ? moveDistance : -(moveDistance))
        
        UIView.animate(withDuration: duration, animations: {
            self.menuView?.frame.origin.y += movement
        }, completion: {(success) in
            if success {
                self.menuView?.frame.origin.y += movement
                self.menuViewBottomConst?.constant = (show ? movement : 0)
            }
        })
    }

}
