//
//  MyMenuBarItemViewController.swift
//  TopMenuBarDemo
//
//  Created by Yiyin Shen on 12/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class MyMenuBarItemView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}

extension MyMenuBarItemView: TopMenuBarItemViewProtocol{
    func configure(with model: TopMenuBarItemModelProtocol) {
        if let model = model as? MyTopMenuBarItemModel {
            label.text = model.description
            imageView.image = UIImage(named: model.imageName)
        }
    }
}
