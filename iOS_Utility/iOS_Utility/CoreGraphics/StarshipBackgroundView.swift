//
//  StarshipBackgroundView.swift
//  iOS_Utility
//
//  Created by JS_Ju on 2021/01/19.
//  Copyright © 2021 Joongsun Joo. All rights reserved.
//

import UIKit

class StarshipBackgroundView: UIView {

   
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
//        context.setFillColor(UIColor.white.cgColor)
//        context.fill(bounds)
        
        let backgroundRect = bounds
        context.drawLinearGradient(in: backgroundRect, startingWith: UIColor.starwarsStarshipGrey.cgColor, finishingWith: UIColor.black.cgColor)
        
        context.setFillColor(UIColor.red.cgColor)
        drawBlueCircle(context)
        context.fill(CGRect(x: self.frame.maxX / 4, y: self.frame.maxY / 4, width: self.frame.width / 2, height: self.frame.height / 2))
        
        drawBorder(context, backgroundRect)
        
        drawLines(context)
    }
   

    func drawBlueCircle(_ context: CGContext) {
        context.saveGState()
        context.setFillColor(UIColor.blue.cgColor)
        context.addEllipse(in: bounds)
        context.drawPath(using: .fill)
        context.restoreGState()
    }
    
    func drawBorder(_ context: CGContext, _ rect: CGRect) {
        let strokeRect = rect.insetBy(dx: 4.5, dy: 4.5)
        context.setStrokeColor(UIColor.starwarsYellow.cgColor)
        context.setLineWidth(1.0)
        context.stroke(strokeRect)
    }
    
    func drawLines(_ context: CGContext) {
        context.setStrokeColor(UIColor.starwarsYellow.cgColor)
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: 10, y: 10))
        context.addLine(to: CGPoint(x: 300, y: 10))
        context.addLines(between: [CGPoint(x: 10, y: 20), CGPoint(x: 300, y: 20)])
        
        context.strokePath()
    }
}

/// Drawing Gradients
extension CGContext {
    func drawLinearGradient(in rect: CGRect, startingWith startColor: CGColor, finishingWith endColor: CGColor) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let locations = [0.0, 1.0] as [CGFloat]
        
        let colors = [startColor, endColor] as CFArray
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors: colors,
                                        locations: locations) else {
            print("Can't get CGGradient")
            return }
        
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        
        saveGState()
        
        addRect(rect)
        clip()
        drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions())
        
        restoreGState()
    }
}
