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
    
    // Creating New Colors
    @IBOutlet weak var starwarsYellowView: UIView!
    @IBOutlet weak var starwarsSpaceBlueView: UIView!
    @IBOutlet weak var starwarsStarshipGreyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCreatingNewColors()
        setDrawingScroll()
        setDrawingRectanglesView()
        setNextDrawingButton()
        setDrawingImageView()
        setArcFooterView()
    }

    // Drawing
    @IBOutlet weak var drawingLabel: UILabel!
    lazy var drawingScroll: UIScrollView =  { return UIScrollView() }()
    lazy var drawingRectanglesView: StarshipBackgroundView = { return StarshipBackgroundView() }()
    lazy var drawingImageView: UIImageView = { return UIImageView() }()
    lazy var drawingNextButton: UIButton = { return UIButton() }()
    
    lazy var arcFooterView: CustomFooter = { return CustomFooter() }()
    
    @objc func drawNext() {
        let size = 8
        
        drawingNextButton.tag = (drawingNextButton.tag + 1) % size
        
        switch drawingNextButton.tag {
        case 0:
            drawRectInDrawingImageView()
        case 1:
            drawCircleInDrawingImaageView()
        case 2:
            drawCheckerboardInDrawingImageView()
        case 3:
            drawFlaidInDrawingImageView()
        case 4:
            drawRotatedSquarsInDrawingImageView()
        case 5:
            drawLinesInDrawingImageView()
        case 6:
            drawImagesAndTextInDrawingImageView()
        case 7:
            drawArcsINDrawingImageView()
        default:
            drawRectInDrawingImageView()
        }
    }
}

///
/// Creating New Colors
///
extension UIColor {
    public static let starwarsYellow = UIColor(red: 250/255, green: 202/255, blue: 56/255, alpha: 1.0)
    public static let starwarsSpaceBlue = UIColor(red: 5/255, green: 10/255, blue: 85/255, alpha: 1.0)
    public static let starwarsStarshipGrey = UIColor(red: 159/255, green: 150/255, blue: 135/255, alpha: 1.0)
}

private extension CoreGraphicsViewController {
    func setCreatingNewColors() {
        starwarsYellowView.backgroundColor = .starwarsYellow
        starwarsSpaceBlueView.backgroundColor = .starwarsSpaceBlue
        starwarsStarshipGreyView.backgroundColor = .starwarsStarshipGrey
    }
    
    func setDrawingScroll() {
        drawingScroll.translatesAutoresizingMaskIntoConstraints = false
//        drawingScroll.isPagingEnabled = true
        drawingScroll.isScrollEnabled = true
        drawingScroll.backgroundColor = .systemGroupedBackground
        
        let topConst = NSLayoutConstraint.init(item: drawingScroll, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: drawingLabel, attribute: .bottom,
                                               multiplier: 1.0, constant: 8)
        let leadingConst = NSLayoutConstraint.init(item: drawingScroll, attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view, attribute: .leading,
                                                   multiplier: 1.0, constant: 0)
        let trailingConst = NSLayoutConstraint.init(item: drawingScroll, attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view, attribute: .trailing,
                                                    multiplier: 1.0, constant: 0)
        let bottomConst = NSLayoutConstraint.init(item: drawingScroll, attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view, attribute: .bottom,
                                                  multiplier: 1.0, constant: 0)
        
        view.addSubview(drawingScroll)
        view.addConstraints([topConst, leadingConst, trailingConst, bottomConst])
    }
    
    func updateContentSizeDrawingScroll(at lastItem: UIView) {
        let contentHeight = lastItem.frame.height
        let contentWidth = UIScreen.main.bounds.width
        drawingScroll.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    func updateContentSizeDrawingScroll(at lastItem: CGRect) {
        let contentHeight = drawingScroll.contentSize.height + lastItem.height
        let contentWidth = drawingScroll.contentSize.width != 0 ? drawingScroll.contentSize.width : UIScreen.main.bounds.width
        drawingScroll.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    func updateContentSizeDrawingScroll(height: CGFloat) {
        let contentHeight = drawingScroll.contentSize.height + height
        let contentWidth = drawingScroll.contentSize.width != 0 ? drawingScroll.contentSize.width : UIScreen.main.bounds.width
        drawingScroll.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    func updateContentSizeDrawingScroll(width: () -> CGFloat, height: () -> CGFloat) {
        drawingScroll.contentSize = CGSize(width: width(), height: height())
    }
    
    func setDrawingRectanglesView() {
        drawingRectanglesView.frame = CGRect(x: drawingScroll.frame.minX,
                                             y: drawingScroll.frame.minY,
                                             width: UIScreen.main.bounds.width,
                                             height: CGFloat(320))
        updateContentSizeDrawingScroll(at: drawingRectanglesView)
        drawingScroll.addSubview(drawingRectanglesView)
    }
    
    func setNextDrawingButton() {
        drawingNextButton.frame = CGRect(x: CGFloat(18),
                                            y: drawingScroll.contentSize.height + CGFloat(10),
                                            width: CGFloat(100),
                                            height: CGFloat(20))
        drawingNextButton.setTitle("Next", for: .normal)
        drawingNextButton.setTitleColor(.systemBlue, for: .normal)
        drawingNextButton.addTarget(self, action: #selector(drawNext), for: .touchUpInside)
        drawingNextButton.tag = 0
        
        updateContentSizeDrawingScroll(at: drawingNextButton.frame)
        
        drawingScroll.addSubview(drawingNextButton)
    }
    
    func setDrawingImageView() {
        drawingImageView.frame = CGRect(x: CGFloat(0),
                                        y: drawingScroll.contentSize.height + CGFloat(18),
                                        width: CGFloat(512),
                                        height: CGFloat(512))
        updateContentSizeDrawingScroll { () -> CGFloat in
            drawingScroll.contentSize.width > drawingImageView.frame.width ? drawingScroll.contentSize.width : drawingImageView.frame.width
        } height: { () -> CGFloat in
            drawingImageView.frame.maxY
        }

        drawingScroll.addSubview(drawingImageView)
        
        drawRectInDrawingImageView()
    }

    func drawRectInDrawingImageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: CGFloat(512), height: CGFloat(512)))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        drawingImageView.image = img
    }
    
    func drawCircleInDrawingImaageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: CGFloat(512), height: CGFloat(512)))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        drawingImageView.image = img
    }
    
    func drawCheckerboardInDrawingImageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        drawingImageView.image = img
    }
    
    func drawFlaidInDrawingImageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(1)
            
            for row in 0 ... 8 {
                ctx.cgContext.addLines(between: [CGPoint(x: 0, y: 0 + (row * 64)), CGPoint(x: 512, y: 0 + (row * 64))])
            }
            
            for col in 0 ... 8 {
                ctx.cgContext.addLines(between: [CGPoint(x: 0 + (col * 64), y: 0), CGPoint(x: 0 + (col * 64), y: 512)])
            }
            
            ctx.cgContext.strokePath()
        }

        drawingImageView.image = img
    }
    
    func drawRotatedSquarsInDrawingImageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        drawingImageView.image = img
    }
    
    func drawLinesInDrawingImageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        drawingImageView.image = img
    }
    
    func drawImagesAndTextInDrawingImageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font : UIFont.systemFont(ofSize: 36),
                .paragraphStyle : paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let simbol = UIImage(named: "Swift-2-512")
            simbol?.draw(in: CGRect(x: 150, y: 150, width: 256, height: 256))
            
        }
        
        drawingImageView.image = img
    }
    
    func drawArcsINDrawingImageView() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let center = CGPoint(x: 0, y: 0)
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            // background cicle
            ctx.cgContext.setFillColor(UIColor.lightGray.cgColor)
            ctx.cgContext.addArc(center: center, radius: CGFloat(128), startAngle: .pi * (0), endAngle: .pi * 2, clockwise: false)
            ctx.cgContext.fillPath()
            
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.addArc(center: center, radius: CGFloat(48), startAngle: .pi * (0), endAngle: .pi * 2, clockwise: false)
            ctx.cgContext.fillPath()
            
            // arc
            let startAngle = CGFloat.pi * (3/2)
            let endAngle = CGFloat.pi * (3/4)
            
            ctx.cgContext.setStrokeColor(UIColor.blue.cgColor)
            ctx.cgContext.setLineWidth(80)
            ctx.cgContext.addArc(center: center, radius: CGFloat(88), startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            ctx.cgContext.drawPath(using: .stroke)
            
            // outline
//            let angleDifference: CGFloat = 2 * CGFloat.pi - startAngle + endAngle
            
            // draw the outer arc
            let outlinePath = UIBezierPath(arcCenter: center, radius: CGFloat(128), startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            // draw the inner arc
            outlinePath.addArc(withCenter: center, radius: CGFloat(48), startAngle: endAngle, endAngle: startAngle, clockwise: false)
            
            // close the path
            outlinePath.close()
            
            ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
            outlinePath.lineWidth = CGFloat(1)
            outlinePath.stroke()
            
        }
        
        drawingImageView.image = img
    }
    
    func setArcFooterView() {
        arcFooterView.frame = CGRect(x: drawingScroll.frame.minX,
                                     y: drawingScroll.contentSize.height + CGFloat(12),
                                             width: UIScreen.main.bounds.width,
                                             height: CGFloat(80))
        updateContentSizeDrawingScroll { () -> CGFloat in
            drawingScroll.contentSize.width > arcFooterView.frame.width ? drawingScroll.contentSize.width : arcFooterView.frame.width
        } height: { () -> CGFloat in
            arcFooterView.frame.maxY
        }
        drawingScroll.addSubview(arcFooterView)
    }
}

