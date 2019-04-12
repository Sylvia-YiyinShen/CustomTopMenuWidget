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

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.orange
    }
    
    func configure(with models: [TopMenuBarItemModelProtocol]) {
        self.models = models
        configureMenuScrollView()
        configureDetailScrollView()
        addChildDetailsViewController()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let models = models else { return }
        let menuBarHeight = 44.0
        menuScrollView?.frame = CGRect(x: 0.0, y: 0.0, width: Double(frame.size.width), height: menuBarHeight)
        detailScollView?.frame = CGRect(x: 0.0, y: menuBarHeight, width: Double(frame.size.width), height: Double(frame.size.height) - menuBarHeight)
        detailScollView?.contentSize = CGSize(width: CGFloat(models.count) * frame.size.width, height: detailScollView!.frame.height)
        for (index, detailView) in detailsViews.enumerated() {
            detailView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: CGFloat(detailScollView!.frame.size.height))
        }
    }
    
    private func addChildDetailsViewController() {
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
        menuScrollView?.backgroundColor = UIColor.red
        addSubview(menuScrollView!)
    }
    
    private func configureDetailScrollView() {
        detailScollView = UIScrollView()
        detailScollView?.isPagingEnabled = true
        detailScollView?.bounces = false
        addSubview(detailScollView!)
    }
}
