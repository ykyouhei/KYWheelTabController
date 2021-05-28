//
//  KYWheelTabController.swift
//  KYWheelTabController
//
//  Created by kyo__hei on 2016/02/20.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit

open class KYWheelTabController: UITabBarController {
    
    /* ====================================================================== */
    // MARK: Properties
    /* ====================================================================== */
    
    @IBInspectable open var tintColor: UIColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1) {
        didSet {
            wheelMenuView.tintColor = tintColor
        }
    }
    
    override open var viewControllers: [UIViewController]? {
        didSet {
            wheelMenuView.tabBarItems = tabBarItems
        }
    }
    
    open internal(set) lazy var wheelMenuView: WheelMenuView = {
        return WheelMenuView(
            frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 201, height: 201)),
            tabBarItems: self.tabBarItems)
    }()
    
    fileprivate var tabBarItems: [UITabBarItem] {
        return viewControllers?.map { $0.tabBarItem } ?? []
    }
    
    
    /* ====================================================================== */
    // MARK:  Life Cycle
    /* ====================================================================== */
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = true
        
        wheelMenuView.tintColor = tintColor
        wheelMenuView.delegate = self
        wheelMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wheelMenuView)
        let window = UIApplication.shared.windows[0]
        let safeFrame = window.safeAreaLayoutGuide.layoutFrame
        
        view.addConstraints([
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .width,
                multiplier: 1.0,
                constant: 201
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .height,
                multiplier: 1.0,
                constant: 201
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: view,
                attribute: .centerX,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: view,
                attribute: .bottom,
                multiplier: 1.0,
                constant: 34 - safeFrame.minY
            )
        ])
    }

}

extension KYWheelTabController: WheelMenuViewDelegate {
    
    public func wheelMenuView(_ view: WheelMenuView, didSelectItem: UITabBarItem) {
        selectedIndex = view.selectedIndex
    }
    
}
