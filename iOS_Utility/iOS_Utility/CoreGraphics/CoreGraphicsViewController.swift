//
//  CoreGraphicsViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/04/27.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class CoreGraphicsViewController: UIViewController {

    var backClosure: ((_ vc: UIViewController?) -> Void)?
    
    @IBAction func backButtonClicked(_ sender: Any) {
        backClosure?(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
