//
//  MainViewController.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/02/12.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let menuList = ["Left slide menu", "Core graphics"]
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
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

private extension MainViewController {
    func moveView(_ index: Int) {
        switch index {
        case 0:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftSlideMenu") as! LeftSlideMenuViewController
            vc.backClosure = {vc in vc?.navigationController?.popViewController(animated: true)}
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 1:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CoreGraphics") as! CoreGraphicsViewController
            vc.backClosure = {vc in vc?.navigationController?.popViewController(animated: true)}
            self.navigationController?.pushViewController(vc, animated: true)
            return
        default:
            return
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        cell.titleLabel.text = menuList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2), height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("index: \(indexPath.row), item: \(menuList[indexPath.row])")
        moveView(indexPath.row)
    }
}
