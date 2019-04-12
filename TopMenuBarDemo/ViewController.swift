//
//  ViewController.swift
//  TopMenuBarDemo
//
//  Created by Yiyin Shen on 12/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topMenuBarView: TopMenuBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuBarView()
    }
    
    private func configureMenuBarView() {
        topMenuBarView.configure(with: menuItemModels)
    }

    private var menuItemModels: [MyTopMenuBarItemModel] {
        let theFool = MyTopMenuBarItemModel(title: "The Fool", imageName: "the_fool", description: "The Fool is a very powerful card in the Tarot deck, usually representing a new beginning -- and, consequently, an end to something in your old life. The Fool's position in your spread reveals which aspects of your life may be subject to change. The Fool portends important decisions ahead which may not be easy to make, and involve an element of risk for you. Approach the changes with optimism and care to gain the most positive outcome.")
        let theMagician = MyTopMenuBarItemModel(title: "The Magician", imageName: "the_magician", description: "The Magician generally associates with intelligent and skillful communicators. His presence in your spread indicates a level of self-confidence and drive which allows you to translate ideas into action. A practical card, the revelations it brings are best applied to the pragmatic and physical aspects of your life, rather then the ephemeral or theoretical. Your success in upcoming ventures in politics or business will likely hinge upon your own strength of will and determination.")
        let theHighPriestess = MyTopMenuBarItemModel(title: "The High Priestess", imageName: "the_high_priestess", description: "Your identification with the High Priestess suggests you possess inherent good judgment, in the form of strong intuition. She may indicate that reason should take second place to instinct. Your head must trust in the wisdom of your heart for a change. Yet, she is also an aide by nature, and her presence in certain parts of your spread could be indicative of someone close to you coming to your rescue with their own intuition. ")
        return [theFool, theMagician, theHighPriestess]
    }
    
    private var menuDetailsViews: [MyMenuBarItemView] {
        return [MyMenuBarItemView.loadFromXib(),
                MyMenuBarItemView.loadFromXib(),
                MyMenuBarItemView.loadFromXib()
        ]
    }
}

