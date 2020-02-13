//
//  ViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/01/24.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadMainView()
    }

}

private extension ViewController {
    func loadMainView() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as! MainViewController
        
        let naviVC = UINavigationController.init(rootViewController: mainVC)
        naviVC.modalPresentationStyle = .fullScreen
        self.navigationController?.isNavigationBarHidden = true
        
        self.present(naviVC, animated: false, completion: nil)
    }
}
