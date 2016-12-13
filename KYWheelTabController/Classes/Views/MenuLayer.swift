//
//  MenuLayer.swift
//  KYWheelTabController
//
//  Created by kyo__hei on 2016/02/20.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit

internal class MenuLayer: CAShapeLayer {
    
    /* ====================================================================== */
    // MARK: Properties
    /* ===================================================================== */
    
    let tabBarItem: UITabBarItem
    
    var tintColor: UIColor = UIColor(colorLiteralRed: 0, green: 122/255, blue: 1, alpha: 1) {
        didSet {
            updateContents()
        }
    }
    
    var selected = false {
        didSet {
            updateContents()
        }
    }
    
    fileprivate let disableColor = UIColor(white: 0.4, alpha: 1)
    
    fileprivate let contentsLayer: CALayer
    
    fileprivate let arcLayer: CAShapeLayer
    
    
    /* ====================================================================== */
    // MARK: initializer
    /* ====================================================================== */
    
    init(center: CGPoint,
        radius: CGFloat,
        startAngle: CGFloat,
        endAngle: CGFloat,
        tabBarItem: UITabBarItem,
        bounds: CGRect,
        contentsTransform: CATransform3D)
    {
        self.tabBarItem = tabBarItem
        
        let scale    = UIScreen.main.scale
        let arcWidth = CGFloat(5)
        
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: center,
            radius: bounds.width/2 - arcWidth/2,
            startAngle: startAngle-0.01,
            endAngle: endAngle+0.01,
            clockwise: true)
        
        arcLayer             = CAShapeLayer()
        arcLayer.path        = bezierPath.cgPath
        arcLayer.lineWidth   = arcWidth
        arcLayer.fillColor   = UIColor.clear.cgColor
        
        contentsLayer                    = CALayer()
        contentsLayer.frame              = bounds
        contentsLayer.contentsGravity    = kCAGravityCenter
        contentsLayer.contentsScale      = scale
        contentsLayer.transform          = contentsTransform
        contentsLayer.rasterizationScale = scale
        contentsLayer.shouldRasterize    = true
        
        super.init()
        
        let path = UIBezierPath()
        path.addArc(withCenter: center,
            radius: bounds.width/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        path.addLine(to: center)
        
        self.path          = path.cgPath
        lineWidth          = 1
        rasterizationScale = scale
        shouldRasterize    = true
        
        updateContents()
        
        addSublayer(contentsLayer)
        addSublayer(arcLayer)
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func updateContents() {
        if selected {
            contentsLayer.contents = tabBarItem.selectedImage?.cgImage
            arcLayer.strokeColor = tintColor.cgColor
        } else {
            contentsLayer.contents = tabBarItem.image?.cgImage
            arcLayer.strokeColor = UIColor.clear.cgColor
        }
    }

}
