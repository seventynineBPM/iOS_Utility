//
//  CustomFooter.swift
//  iOS_Utility
//
//  Created by JS_Ju on 2021/02/04.
//  Copyright © 2021 Joongsun Joo. All rights reserved.
//
//  Reference : https://www.raywenderlich.com/349664-core-graphics-tutorial-arcs-and-paths
//

import UIKit

class CustomFooter: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(bounds)
        
        let footerRect = CGRect(x: bounds.origin.x,
                                y: bounds.origin.y,
                                width: bounds.width,
                                height: bounds.height)
        
        var arcRect = footerRect
        arcRect.size.height = 8
        
        context.saveGState()
        let arcPath = CGContext.createArcPathFromBottom(of: arcRect,
                                                        arcHeight: 8,
                                                        startAngle: Angle(degrees: 180),
                                                        endAngle: Angle(degrees: 360))
        context.addPath(arcPath)
        context.clip()
        
        context.drawLinearGradient(in: footerRect,
                                   startingWith: UIColor.opaqueSeparator.cgColor,
                                   finishingWith: UIColor.darkGray.cgColor)
        
        context.addRect(footerRect)
        context.addPath(arcPath)
        context.clip(using: .evenOdd)
        context.addPath(arcPath)
        context.setShadow(offset: CGSize(width: 0, height: 2),
                          blur: 3,
                          color: UIColor.lightGray.cgColor)
        context.fillPath()
    }
}

typealias Angle = Measurement<UnitAngle>

extension Measurement where UnitType == UnitAngle {
    init(degrees: Double) {
        self.init(value: degrees, unit: .degrees)
    }
    
    func toRadiants() -> Double {
        return converted(to: .radians).value
    }
}

extension CGContext {
    static func createArcPathFromBottom(
        of rect: CGRect,
        arcHeight: CGFloat,
        startAngle: Angle,
        endAngle: Angle) -> CGPath {
        let arcRect = CGRect(x: rect.origin.x,
                             y: rect.origin.y + rect.height,
                             width: rect.width,
                             height: rect.height)
        
        let arcRadius = (arcRect.height / 2) * pow(arcRect.width, 2) / (8 * arcRect.height)
        let arcCenter = CGPoint(x: arcRect.origin.x + arcRect.width / 2,
                                y: arcRect.origin.y + arcRadius)
        let angle = acos(arcRect.width / (2 * arcRadius))
        let startAngle = CGFloat(startAngle.toRadiants()) + angle
        let endAngle = CGFloat(endAngle.toRadiants()) - angle
        
        let path = CGMutablePath()
        
        path.addArc(center: arcCenter,
                    radius: arcRadius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        return path.copy()!
    }
}


