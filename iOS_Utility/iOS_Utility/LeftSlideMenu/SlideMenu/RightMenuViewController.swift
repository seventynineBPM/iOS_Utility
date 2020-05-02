//
//  RightMenuViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/05/01.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class RightMenuViewController: SlideMenuViewController {

    /*
     * override initialization functions
     */
    override func initMenuView() {
        let menuView = UIView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.backgroundColor = .white
        self.view.addSubview(menuView)
        
        let topConst = NSLayoutConstraint.init(item: menuView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConst = NSLayoutConstraint.init(item: menuView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConst = NSLayoutConstraint.init(item: menuView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let widthConst = NSLayoutConstraint.init(item: menuView, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: options.viewLength)

        self.view.addConstraints([topConst,bottomConst,leadingConst,widthConst])
        
        self.menuView = menuView
        self.menuViewLeadingConst = leadingConst
    }

    override func moveMenuView(moveDistance: CGFloat, show: Bool, duration: TimeInterval) {
        let movement: CGFloat = CGFloat(show ? -(moveDistance) : moveDistance)
        
        UIView.animate(withDuration: duration, animations: {
            self.menuView?.frame.origin.x += movement
        }, completion: {(success) in
            if success {
                self.menuView?.frame.origin.x += movement
                self.menuViewLeadingConst?.constant = (show ? movement : 0)
            }
        })
    }
}
