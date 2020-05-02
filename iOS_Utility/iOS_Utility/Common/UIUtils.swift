//
//  UIUtils.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/02/13.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import Foundation
import UIKit

class UIUtils {
    /*
     * iPhone Xmax, XR, XsMax, 11pro Max - 414 x 896
     * iPhone 11pro,X, Xs - 375 x 812
     * iPhone 6+, 6s+, 7+, 8+ - 414 x 736
     * iPhone 6, 6s, 7, 8 - 375 x 667
     * iPhone 5, 5s, 5c, SE - 320 x 568
     * iPhone 4, 4s, 2G, 3G, 3GS - 320 x 480
     */
    public static func getDeviceScreenType() -> DEVICE_SCREEN_TYPE {
        var screenWidth = UIUtils.getScreenWidth()
        var screenHeight = UIUtils.getScreenHeight()

        // 세로모드 기준으로 판단
        if screenWidth > screenHeight {
            let temp = screenWidth
            screenWidth = screenHeight
            screenHeight = temp
        }
        
        switch screenHeight/screenWidth {
        case 896/414:
            return DEVICE_SCREEN_TYPE.XSMax_6_1
        case 812/375:
            return DEVICE_SCREEN_TYPE.X_5_8
        case 736/414:
            return DEVICE_SCREEN_TYPE.PLUS_5_5
        case 667/375:
            return DEVICE_SCREEN_TYPE.NORMAL_4_7
        case 568/320:
            return DEVICE_SCREEN_TYPE.SE_4
        case 480/320:
            return DEVICE_SCREEN_TYPE.OLD_3_5
        default:
            return DEVICE_SCREEN_TYPE.OTHER
        }
    }
    
    public static func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public static func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
        
    }
    
    public static func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public static func UIColorFromARGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
        )
    }
    
    public static func showSimpleAlert(title: String?, message: String, closeVC: UIViewController? = nil) {
//        owner.view.endEditing(true)
        if let closeViewController = closeVC {               // 키패드 있다면 닫기
            closeViewController.view.endEditing(true)
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) {
            UIAlertAction in
        
            if let closeViewController = closeVC {
                closeViewController.navigationController?.popViewController(animated: true)
                closeViewController.dismiss(animated: false, completion: nil)
            }
        }
        alertController.addAction(okAction)
        if let topVC = UIApplication.topViewController() {  // 앨럿띄우기
            topVC.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    public static func widthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
    /**
        앱 설치 여부 확인. Scheme String 으로 판별.
    */
    public static func isAppInstalled(scheme: String) -> Bool {
        
        guard let urlScheme = URL(string: scheme) else {
            return false
        }
    
        if UIApplication.shared.canOpenURL(urlScheme) {
            return true
        } else {
            return false
        }
    
    }
    
    ///
    /// 이미지를 회전 시킨다.
    ///
    static func rotateImage(imageView: UIImageView, aCircleTime: Double, isClockwise: Bool, key: String) { //CABasicAnimation
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = (isClockwise ? Double.pi * 2 : -Double.pi * 2) //Minus can be Direction
        rotationAnimation.duration = aCircleTime
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: key)
    }
}

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            let top = topViewController(nav.visibleViewController)
            return top
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                let top = topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController {
            let top = topViewController(presented)
            return top
        }
        
        if let alert = base as? UIAlertController {
            return alert.presentingViewController
        }
        
        // delegate 가 없는 popover는 없다는 전제
        if let alert = base?.popoverPresentationController, alert.delegate != nil{
            return alert.presentingViewController
        }
        
        return base
    }
}

enum DEVICE_SCREEN_TYPE: Int {
    case X_5_8 = 0              // iPhone X, XS
    case PLUS_5_5 = 1           // iPhone 6+, 6s+, 7+, 8+
    case NORMAL_4_7 = 2         // iPhone 6, 6s, 7, 8
    case SE_4 = 3               // iPhone 5, 5s, 5c, SE
    case OLD_3_5 = 4            // iPhone 4, 4s, 2G, 3G, 3GS
    case XSMax_6_1 = 5          // iPhone X Max, XR
    case OTHER = 100              // 그 외 경우. 신규 디바이스 출시 경우에 대비 한 케이스

    func code() -> Int {
        switch self {
        case .X_5_8:
            return 0
        case .PLUS_5_5:
            return 1
        case .NORMAL_4_7:
            return 2
        case .SE_4:
            return 3
        case .OLD_3_5:
            return 4
        case .XSMax_6_1:
            return 5
        case .OTHER:
            return 100
        }
    }

    func desc() -> String {
        switch self {
        case .X_5_8:
            return "X"
        case .PLUS_5_5:
            return "+"
        case .NORMAL_4_7:
            return "NORMAL"
        case .SE_4:
            return "SE"
        case .OLD_3_5:
            return "OLD"
        case .XSMax_6_1:
            return "XS"
        case .OTHER:
            return "OTHER"
        }
    }
}
