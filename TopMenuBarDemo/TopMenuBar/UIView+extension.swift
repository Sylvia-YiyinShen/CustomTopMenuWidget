//
//  UIView+extension.swift
//  TopMenuBarDemo
//
//  Created by Yiyin Shen on 12/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

extension UIView
{
    static func loadFromXib<T>() -> T where T: UIView
    {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
}
