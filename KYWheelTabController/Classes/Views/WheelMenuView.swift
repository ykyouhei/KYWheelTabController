//
//  WheelMenuView.swift
//  KYCircleTabController
//
//  Created by kyo__hei on 2016/02/03.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit

public protocol WheelMenuViewDelegate: NSObjectProtocol {
    
    func wheelMenuView(view: WheelMenuView, didSelectItem: UITabBarItem)
    
}


@IBDesignable public final class WheelMenuView: UIView {
    
    /* ====================================================================== */
    // MARK: Properties
    /* ====================================================================== */
    
    @IBInspectable public var centerButtonRadius: CGFloat = 32 {
        didSet {
            updateCenterButton()
        }
    }
    
    @IBInspectable public var menuBackGroundColor: UIColor = UIColor(white: 36/255, alpha: 1) {
        didSet {
            menuLayers.forEach {
                $0.fillColor = menuBackGroundColor.CGColor
            }
        }
    }
    
    @IBInspectable var boarderColor: UIColor = UIColor(white: 0.4, alpha: 1) {
        didSet {
            menuLayers.forEach {
                $0.strokeColor = boarderColor.CGColor
            }
        }
    }
    
    @IBInspectable public var animationDuration: CGFloat = 0.2
    
    
    public weak var delegate: WheelMenuViewDelegate?
    
    public var tabBarItems: [UITabBarItem] {
        get {
            return menuLayers.map { $0.tabBarItem }
        } set {
            menuLayers.forEach{ $0.removeFromSuperlayer() }
            
            let angle = 2 * CGFloat(M_PI) / CGFloat(newValue.count)
            
            menuLayers = newValue.enumerate().map {
                let startAngle = CGFloat($0.index)*angle - angle/2 - CGFloat(M_PI_2)
                let endAngle   = CGFloat($0.index+1)*angle - angle/2 - CGFloat(M_PI_2) - 0.005
                let center     = CGPoint(
                    x: bounds.width/2,
                    y: bounds.height/2)
                
                var transform = CATransform3DMakeRotation(angle * CGFloat($0.index), 0, 0, 1)
                transform     = CATransform3DTranslate(
                    transform,
                    0,
                    -bounds.width/3,
                    0)
                
                let layer = MenuLayer(
                    center: center,
                    radius: bounds.width/2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    tabBarItem: $0.element,
                    bounds: bounds,
                    contentsTransform: transform)
                   
                layer.tintColor   = tintColor
                layer.strokeColor = boarderColor.CGColor
                layer.fillColor   = menuBackGroundColor.CGColor
                layer.selected    = $0.index == selectedIndex
                
                menuBaseView.layer.addSublayer(layer)
                
                return layer
            }
        }
    }
    
    private(set) var openMenu: Bool = true
    
    private(set) var selectedIndex = 0
    
    
    private var startPoint = CGPointZero
    
    private var currentAngle: CGFloat {
        let angle = 2 * CGFloat(M_PI) / CGFloat(menuLayers.count)
        return CGFloat(menuLayers.count - selectedIndex) * angle
    }
    
    private var menuLayers = [MenuLayer]()
    
    
    /* ====================================================================== */
    // MARK: IBOutlet
    /* ====================================================================== */
    
    @IBOutlet private weak var centerButton: UIButton! {
        didSet {
            let bundle = NSBundle(forClass: self.dynamicType)
            let image  = UIImage(named: "Menu", inBundle: bundle, compatibleWithTraitCollection: nil)!
                .imageWithRenderingMode(.AlwaysTemplate)
            centerButton.setImage(image, forState: .Normal)
            centerButton.layer.shadowOpacity = 0.3
            centerButton.layer.shadowRadius  = 10
            centerButton.layer.shadowOffset  = CGSizeZero
        }
    }
    
    @IBOutlet private weak var centerButtonWidth: NSLayoutConstraint!
    
    @IBOutlet private weak var menuBaseView: UIView!
    

    
    /* ====================================================================== */
    // MARK: initializer
    /* ====================================================================== */
    
    convenience public init(frame: CGRect, tabBarItems: [UITabBarItem]) {
        self.init(frame: frame)
        self.tabBarItems = tabBarItems
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comminInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        comminInit()
    }
    
    private func comminInit() {
        let bundle         = NSBundle(forClass: self.dynamicType)
        let nib            = UINib(nibName: "WheelMenuView", bundle: bundle)
        let view           = nib.instantiateWithOwner(self, options: nil).first as! UIView
        let viewDictionary = ["view": view]
        
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: viewDictionary))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: viewDictionary))
        
        updateCenterButton()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        tabBarItems = [
            UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 1),
            UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 2),
            UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 3),
            UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 4)
        ]
    }
    
    
    /* ====================================================================== */
    // MARK: Actions
    /* ====================================================================== */
    
    @IBAction private func handlePanGesture(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(self)
        
        switch sender.state {
        case .Began:
            startPoint = location
            
        case .Changed:
            let radian1 = -atan2(
                startPoint.x - menuBaseView.center.x,
                startPoint.y - menuBaseView.center.y)
            let radian2 = -atan2(
                location.x - menuBaseView.center.x,
                location.y - menuBaseView.center.y)
            
            menuBaseView.transform = CGAffineTransformRotate(
                menuBaseView.transform,
                radian2 - radian1)
            
            startPoint = location
            
        default:
            let angle         = 2 * CGFloat(M_PI) / CGFloat(menuLayers.count)
            var menuViewAngle = atan2(menuBaseView.transform.b, menuBaseView.transform.a)
            
            if menuViewAngle < 0 {
                menuViewAngle += CGFloat(2 * M_PI)
            }
            
            var index = menuLayers.count - Int((menuViewAngle + CGFloat(M_PI_4)) / angle)
            if index == menuLayers.count {
                index = 0
            }
            
            setSelectedIndex(index, animated: true)
            delegate?.wheelMenuView(self, didSelectItem: tabBarItems[index])
        }
    }
    
    @IBAction private func handleTapGesture(sender: UITapGestureRecognizer) {
        let location = sender.locationInView(menuBaseView)
        
        for (idx, menuLayer) in menuLayers.enumerate() {
            let touchInLayer =  CGPathContainsPoint(
                menuLayer.path,
                nil,
                location,
                true)
           
            if touchInLayer {
                setSelectedIndex(idx, animated: true)
                delegate?.wheelMenuView(self, didSelectItem: tabBarItems[idx])
                return
            }
        }
    }
    
    
    @IBAction func didTapCenterButton(_: UIButton) {
        if openMenu {
            closeMenuView()
        } else {
            openMenuView()
        }
    }
    
    
    /* ====================================================================== */
    // MARK: Public Method
    /* ====================================================================== */
    
    public func setSelectedIndex(index: Int, animated: Bool) {
        selectedIndex = index
        
        let duration  = animated ? NSTimeInterval(animationDuration) : 0
        
        UIView.animateWithDuration(NSTimeInterval(duration),
            animations: {
                self.menuBaseView.transform =
                    CGAffineTransformMakeRotation(self.currentAngle)
            },
            completion: { _ in
                self.menuLayers.enumerate().forEach {
                    $0.element.selected = $0.index == index
                }
            }
        )
    }
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        menuLayers.forEach {
            $0.tintColor = tintColor
        }
    }
    
    /* ====================================================================== */
    // MARK: Private Method
    /* ====================================================================== */
    
    private func updateCenterButton() {
        centerButtonWidth.constant      = centerButtonRadius * 2
        centerButton.layer.cornerRadius = centerButtonRadius
    }
    
    private func openMenuView() {
        openMenu = true
        UIView.animateWithDuration(NSTimeInterval(animationDuration),
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 5.0,
            options: [],
            animations: {
                self.menuBaseView.transform = CGAffineTransformRotate(
                    CGAffineTransformMakeScale(1, 1),
                    self.currentAngle)
            },
            completion: nil
        )
    }
    
    private func closeMenuView() {
        openMenu = false
        UIView.animateWithDuration(NSTimeInterval(animationDuration),
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 5.0,
            options: [],
            animations: {
                self.menuBaseView.transform = CGAffineTransformRotate(
                    CGAffineTransformMakeScale(0.1, 0.1),
                    self.currentAngle)
            },
            completion: nil
        )
    }

}
