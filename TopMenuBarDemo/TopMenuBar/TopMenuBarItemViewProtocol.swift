//
//  TopMenuBarItemViewControllerProtocol.swift
//  TopMenuBarDemo
//
//  Created by Yiyin Shen on 12/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

public protocol TopMenuBarItemViewProtocol where Self: UIView {
    func configure(with model: TopMenuBarItemModelProtocol)
}
