//
//  MainViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/02/12.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        initView()
    }

}

private extension MainViewController {
    func initNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initView() {
        
    }
}
