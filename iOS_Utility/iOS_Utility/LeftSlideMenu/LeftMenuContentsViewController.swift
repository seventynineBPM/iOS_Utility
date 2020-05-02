//
//  LeftMenuContentsViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/05/02.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class LeftMenuContentsViewController: SlideMenuContentsViewController {
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        closeClosure?(nil)
    }
    
    @IBAction func menu1ButtonClicked(_ sender: Any) {
        closeClosure?() {
            UIUtils.showSimpleAlert(title: "Menu", message: "Menu1 selected")
        }
    }
    
    @IBAction func menu2ButtonClicked(_ sender: Any) {
        closeClosure?() {
            UIUtils.showSimpleAlert(title: "Menu", message: "Menu1 selected")
        }
    }
    
    @IBAction func menu3ButtonClicked(_ sender: Any) {
        closeClosure?() {
            UIUtils.showSimpleAlert(title: "Menu", message: "Menu1 selected")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
