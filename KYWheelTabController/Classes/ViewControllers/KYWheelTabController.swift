//
//  KYCircleTabController.swift
//  KYWheelTabController
//
//  Created by kyo__hei on 2016/02/20.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit

public class KYCircleTabController: UITabBarController {
    
    /* ====================================================================== */
    // MARK: Properties
    /* ====================================================================== */
    
    @IBInspectable var tintColor: UIColor = UIColor(colorLiteralRed: 0, green: 122/255, blue: 1, alpha: 1) {
        didSet {
            wheelMenuView.tintColor = tintColor
        }
    }
    
    private(set) lazy var wheelMenuView: WheelMenuView = {
        return WheelMenuView(
            frame: CGRect(origin: CGPointZero, size: CGSize(width: 201, height: 201)),
            tabBarItems: self.tabBarItems)
    }()
    
    private var tabBarItems: [UITabBarItem] {
        return viewControllers?.map { $0.tabBarItem } ?? []
    }
    
    
    /* ====================================================================== */
    // MARK:  Life Cycle
    /* ====================================================================== */
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.hidden = true
        
        wheelMenuView.tintColor = tintColor
        wheelMenuView.delegate = self
        wheelMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wheelMenuView)
        
        view.addConstraints([
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1.0,
                constant: 201
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Height,
                multiplier: 1.0,
                constant: 201
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: 44
            )
        ])
    }

}

extension KYCircleTabController: WheelMenuViewDelegate {
    
    public func wheelMenuView(view: WheelMenuView, didSelectItem: UITabBarItem) {
        selectedIndex = view.selectedIndex
    }
    
}
