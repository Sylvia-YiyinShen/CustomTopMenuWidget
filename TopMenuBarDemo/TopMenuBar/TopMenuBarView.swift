//
//  TopMenuBarView.swift
//  TopMenuBarDemo
//
//  Created by Yiyin Shen on 12/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

public class TopMenuBarView<ItemViewType: TopMenuBarItemViewProtocol>: UIView, UIScrollViewDelegate {
    
    // MARK: public customisable propertis
    public var menuBarHeight: CGFloat = 44.0
    public var menuItemWidth: CGFloat = 100.0
    public var menuItemFont: UIFont? = UIFont(name: "Helvetica", size: 17)
    public var menuItemInactiveColor: UIColor = UIColor.white
    public var menuItemActiveColor: UIColor = UIColor.black
    public var menuItemScaleEnabled: Bool = true
    public var menuItemActivatedScale: CGFloat = 1.2
    public var menuBarBackgroundColor: UIColor = UIColor.gray
    public var menuBarAnimated: Bool = true
    
    private var models: [TopMenuBarItemModelProtocol]?
    private var detailsViews: [TopMenuBarItemViewProtocol]?
    private var menuScrollView: UIScrollView?
    private var detailScollView: UIScrollView?
    private var menuItemButtons: [UIButton] = []
    private var activatedMenuButton: UIButton?
    
    public func configure(with models: [TopMenuBarItemModelProtocol], detailsViews: [TopMenuBarItemViewProtocol]) {
        if models.count != detailsViews.count {
            assertionFailure("each model should have one mapped view")
        }
        self.models = models
        self.detailsViews = detailsViews
        configureMenuScrollView()
        configureDetailScrollView()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        guard let models = models, let detailsViews = detailsViews else { return }
        detailScollView?.frame = CGRect(x: 0.0, y: menuBarHeight, width: frame.size.width, height: frame.size.height - menuBarHeight)
        detailScollView?.contentSize = CGSize(width: CGFloat(models.count) * frame.size.width, height: detailScollView!.frame.height)
        for (index, detailView) in detailsViews.enumerated() {
            if let view = detailView as? UIView {
                view.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: CGFloat(detailScollView!.frame.size.height))
            }
        }
        
        menuScrollView?.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: menuBarHeight)
        menuScrollView?.contentSize = CGSize(width: CGFloat(models.count) * menuItemWidth, height: menuScrollView!.frame.height)
        for (index, button) in menuItemButtons.enumerated() {
            button.frame = CGRect(x: menuItemWidth * CGFloat(index), y: 0, width: menuItemWidth, height: menuScrollView!.frame.height)
        }
    }
    
    private func addMenuItemButtons() {
        guard let models = models else { return }
        for (index, model) in models.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(model.title, for: .normal)
            button.setTitleColor(menuItemInactiveColor, for: .normal)
            button.titleLabel?.font = menuItemFont
            button.tag = index
            button.addTarget(self, action: #selector(didTapTitle(button:)), for: .touchUpInside)
            menuItemButtons.append(button)
            menuScrollView?.addSubview(button)
        }
        activateButton(menuItemButtons[0])
    }
    
    @objc
    private func didTapTitle(button: UIButton) {
        detailScollView?.contentOffset = CGPoint(x: CGFloat(button.tag) * frame.width, y: 0)
        activateButton(button)
    }
    
    private func activateButton(_ button: UIButton) {
        activatedMenuButton?.setTitleColor(menuItemInactiveColor, for: .normal)
        activatedMenuButton?.transform = CGAffineTransform.identity
        button.setTitleColor(menuItemActiveColor, for: .normal)
        if menuItemScaleEnabled {
            button.transform = button.transform.scaledBy(x: menuItemActivatedScale, y: menuItemActivatedScale)
        }
        activatedMenuButton = button
        
        centerButton(for: button)
    }
    
    private func centerButton(for button: UIButton) {
        guard let menuScrollView = menuScrollView else { return }
        
        let maxOffset = menuScrollView.contentSize.width - frame.width
        
        var offsetX = button.center.x - frame.width * 0.5
        if offsetX < 0 { offsetX = 0}
        if offsetX > maxOffset { offsetX = maxOffset }
        
        if menuBarAnimated {
            UIView.animate(withDuration: 0.2) {
                menuScrollView.contentOffset = CGPoint(x: offsetX, y: 0)
            }
        } else {
            menuScrollView.contentOffset = CGPoint(x: offsetX, y: 0)
        }
    }
    
    private func addChildDetailsViews() {
        guard let models = models, let detailScollView = detailScollView, let detailsViews = detailsViews else { return }
        for (index, model) in models.enumerated() {
            let detailsView = detailsViews[index]
            (detailsView as? ItemViewType)?.configure(with: model)
            if let view =  detailsView as? UIView {
                detailScollView.addSubview(view)
            }
        }
    }
    
    private func configureMenuScrollView() {
        menuScrollView = UIScrollView()
        menuScrollView?.backgroundColor = menuBarBackgroundColor
        menuScrollView?.showsHorizontalScrollIndicator = false
        addSubview(menuScrollView!)
        addMenuItemButtons()
    }
    
    private func configureDetailScrollView() {
        detailScollView = UIScrollView()
        detailScollView?.isPagingEnabled = true
        detailScollView?.bounces = false
        detailScollView?.delegate = self
        addSubview(detailScollView!)
        addChildDetailsViews()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / frame.size.width)
        let button = menuItemButtons[currentIndex]
        activateButton(button)
    }
}
