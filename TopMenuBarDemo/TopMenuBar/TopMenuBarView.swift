//
//  TopMenuBarView.swift
//  TopMenuBarDemo
//
//  Created by Zhihui Sun on 12/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

@IBDesignable
class TopMenuBarView: UIView {
    private var models: [TopMenuBarItemModelProtocol]?
    private var menuScrollView: UIScrollView?
    private var detailScollView: UIScrollView?
    private var detailsViews: [UIView] = []
    private var menuItemButtons: [UIButton] = []
    private var activatedMenuButton: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.orange
    }
    
    func configure(with models: [TopMenuBarItemModelProtocol]) {
        self.models = models
        configureMenuScrollView()
        configureDetailScrollView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let models = models else { return }
        let menuBarHeight = 44.0
        detailScollView?.frame = CGRect(x: 0.0, y: menuBarHeight, width: Double(frame.size.width), height: Double(frame.size.height) - menuBarHeight)
        detailScollView?.contentSize = CGSize(width: CGFloat(models.count) * frame.size.width, height: detailScollView!.frame.height)
        for (index, detailView) in detailsViews.enumerated() {
            detailView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: CGFloat(detailScollView!.frame.size.height))
        }
        
        let buttonWidth = CGFloat(100)
        menuScrollView?.frame = CGRect(x: 0.0, y: 0.0, width: Double(frame.size.width), height: menuBarHeight)
        menuScrollView?.contentSize = CGSize(width: CGFloat(models.count) * buttonWidth, height: menuScrollView!.frame.height)
        for (index, button) in menuItemButtons.enumerated() {
            button.frame = CGRect(x: buttonWidth * CGFloat(index), y: 0, width: buttonWidth, height: menuScrollView!.frame.height)
        }
    }
    
    private func addMenuItemButtons() {
        guard let models = models else { return }
        for (index, model) in models.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(model.title, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
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
        activatedMenuButton?.setTitleColor(UIColor.white, for: .normal)
        activatedMenuButton?.transform = CGAffineTransform.identity
        button.setTitleColor(UIColor.black, for: .normal)
        button.transform = button.transform.scaledBy(x: 1.2, y: 1.2)
        activatedMenuButton = button
        
        centerButton(for: button)
    }
    
    private func centerButton(for button: UIButton) {
        guard let menuScrollView = menuScrollView else { return }
        
        let maxOffset = menuScrollView.contentSize.width - frame.width
        
        var offsetX = button.center.x - frame.width * 0.5
        if offsetX < 0 { offsetX = 0}
        if offsetX > maxOffset { offsetX = maxOffset }
        
        UIView.animate(withDuration: 0.2) {
            menuScrollView.contentOffset = CGPoint(x: offsetX, y: 0)
        }
    }
    
    private func addChildDetailsViews() {
        guard let models = models, let detailScollView = detailScollView else { return }
        for model in models {
            let detailsView = MyMenuBarItemView.loadFromXib() as MyMenuBarItemView
            detailsView.configure(with: model)
            detailsViews.append(detailsView)
            detailScollView.addSubview(detailsView)
        }
    }
    
    
    private func configureMenuScrollView() {
        menuScrollView = UIScrollView()
        menuScrollView?.backgroundColor = UIColor.gray
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
}

extension TopMenuBarView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / frame.size.width)
        let button = menuItemButtons[currentIndex]
        activateButton(button)
    }
}
