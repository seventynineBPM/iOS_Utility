//
//  LeftSlideMenuViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/04/27.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class LeftSlideMenuViewController: UIViewController {

    var backClosure: ((_ vc: UIViewController?) -> Void)?
    
    @IBAction func backClicked(_ sender: Any) {
        backClosure?(self)
    }
    
    @IBAction func openLeftMenuClicked(_ sender: Any) {
        openLeftMenuView()
    }
    
    @IBAction func openRightMenuClicked(_ sender: Any) {
        openRightMenuView()
    }
    
    @IBOutlet weak var openBottomButton: UIButton!
    @IBAction func openBottomMenuClicked(_ sender: Any) {
        openBottomMenuView()
    }
    
    @IBOutlet weak var openTopButton: UIButton!
    @IBAction func openTomMenuClicked(_ sender: Any) {
        openTomMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

private extension LeftSlideMenuViewController {
    func openLeftMenuView() {
        let contentsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuContents") as! LeftMenuContentsViewController
        let vc = SlideMenuViewController.getInstance(contents: contentsVC ,option: SlideMenuOption(direction: .fromLeftToRight))
        
        vc.backClosure = {vc, complet in vc?.dismiss(animated: false, completion: complet)}
        present(vc, animated: false, completion: nil)
    }
    
    func openRightMenuView() {
        let contentsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuContents") as! LeftMenuContentsViewController
        let vc = SlideMenuViewController.getInstance(contents: contentsVC ,option: SlideMenuOption(direction: .fromRightToLeft))
        
        vc.backClosure = {vc, complet in vc?.dismiss(animated: false, completion: complet)}
        present(vc, animated: false, completion: nil)
    }
    
    func openBottomMenuView() {
        let height = UIScreen.main.bounds.size.height - (openBottomButton.frame.origin.y + openBottomButton.frame.size.height)
        let contentsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuContents") as! LeftMenuContentsViewController
        let vc = SlideMenuViewController.getInstance(contents: contentsVC ,option: SlideMenuOption(viewLength: height, direction: .fromBottomToTop, backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)))
        
        vc.backClosure = {vc, complet in vc?.dismiss(animated: false, completion: complet)}
        present(vc, animated: false, completion: nil)
    }
    
    func openTomMenuView() {
        let height = openTopButton.frame.origin.y
        let contentsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuContents") as! LeftMenuContentsViewController
        let vc = SlideMenuViewController.getInstance(contents: contentsVC ,option: SlideMenuOption(viewLength: height, direction: .fromTopToBottom, backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)))
        
        vc.backClosure = {vc, complet in vc?.dismiss(animated: false, completion: complet)}
        present(vc, animated: false, completion: nil)
    }
}
