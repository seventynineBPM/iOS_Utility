//
//  SlideMenuViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/05/01.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController {

    var options = SlideMenuOption()
    weak var contentsViewController: UIViewController?
    
    var backClosure: ((_ vc: UIViewController?, _ complete: (() -> Void)?) -> Void)?
    
    var backgroundView: UIView?
    var menuView: UIView?
    var menuViewTrailingConst: NSLayoutConstraint?
    var menuViewLeadingConst: NSLayoutConstraint?
    var menuViewTopConst: NSLayoutConstraint?
    var menuViewBottomConst: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveMenuView(moveDistance: options.viewLength, show: true, duration: TimeInterval(options.animateDulation))
    }

    @objc func dismiss(fromGesture gesture: UITapGestureRecognizer) {
        self.dismissSelf(nil)
    }
 
    class func getInstance(contents: SlideMenuContentsViewController , option: SlideMenuOption) -> SlideMenuViewController {
        let vc = option.direction.getViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.contentsViewController = contents
        vc.options = option
        contents.closeClosure = {[weak vc] complete in vc?.dismissSelf(complete) }
        
        return vc
    }
    
    
    
    /*
     * override functions
     * default : leftSlide
     */
     func initMenuView() {
        let menuView = UIView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.backgroundColor = .white
        self.view.addSubview(menuView)
        
        let topConst = NSLayoutConstraint.init(item: menuView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConst = NSLayoutConstraint.init(item: menuView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let trailingConst = NSLayoutConstraint.init(item: menuView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let widthConst = NSLayoutConstraint.init(item: menuView, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: options.viewLength)

        self.view.addConstraints([topConst,bottomConst,trailingConst,widthConst])
        
        self.menuView = menuView
        self.menuViewTrailingConst = trailingConst
    }
    
    func moveMenuView(moveDistance: CGFloat, show: Bool, duration: TimeInterval) {
        let movement: CGFloat = CGFloat(show ? moveDistance : -(moveDistance))
        
        UIView.animate(withDuration: duration, animations: {
            self.menuView?.frame.origin.x += movement
        }, completion: {(success) in
            if success {
                self.menuView?.frame.origin.x += movement
                self.menuViewTrailingConst?.constant = (show ? movement : 0)
            }
        })
    }
    /*
     * End : override functions
     */
}

private extension SlideMenuViewController {
    func initView() {
        self.view.backgroundColor = options.backgroundColor
        
        initBackground()
        setDismissSelf()
        
        initMenuView()
        initContents()
    }
    
    func initBackground() {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = .clear
        self.view.addSubview(bgView)
        
        bgView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        bgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        bgView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        bgView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        
        self.backgroundView = bgView
    }
    
    func setDismissSelf() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        self.backgroundView?.addGestureRecognizer(gesture)
    }
    
    func initContents() {
        guard let _ = menuView else {
            return
        }
        
        guard let _ = contentsViewController else {
            return
        }
        
        let contentsView = (contentsViewController?.view)!
        
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        menuView!.addSubview(contentsView)
        self.addChild(contentsViewController!)
        
        contentsViewController?.view.topAnchor.constraint(equalTo: (menuView?.topAnchor)!, constant: 0.0).isActive = true
        contentsViewController?.view.leadingAnchor.constraint(equalTo: (menuView?.leadingAnchor)!, constant: 0.0).isActive = true
        contentsViewController?.view.trailingAnchor.constraint(equalTo: (menuView?.trailingAnchor)!, constant: 0.0).isActive = true
        contentsViewController?.view.bottomAnchor.constraint(equalTo: (menuView?.bottomAnchor)!, constant: 0.0).isActive = true
    }
}

private extension SlideMenuViewController {
    func dismissSelf(_ complete: (() -> Void)?) {
        moveMenuView(moveDistance: options.viewLength, show: false, duration: TimeInterval(options.animateDulation))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.options.animateDulation) {
            self.backClosure?(self, complete)
        }
    }
    
}

class SlideMenuContentsViewController: UIViewController {
    var closeClosure: ((_ complete: (() -> Void)?) -> Void)?
}

// UIButton programatically
        // add button
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Any ...", for: .normal)
//        button.backgroundColor = .darkGray
//        button.addTarget(self, action: #selector(buttonAction(_ :)), for: .touchUpInside)
//        menuView.addSubview(button)
//
//        self.menuView!.addConstraints([NSLayoutConstraint.init(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.menuView!, attribute: .centerX, multiplier: 1.0, constant: 0.0),
//                                       NSLayoutConstraint.init(item: button, attribute: .centerY, relatedBy: .equal, toItem: self.menuView!, attribute: .centerY, multiplier: 1.0, constant: 0.0),
//        NSLayoutConstraint.init(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0),
//        NSLayoutConstraint.init(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0)])
//@objc func buttonAction(_ sender:UIButton!) {
//    print("Any action ....")
//    super.backClosure?(self, nil)
//}
//
