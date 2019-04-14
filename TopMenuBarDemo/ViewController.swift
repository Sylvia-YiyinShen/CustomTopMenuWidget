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
        let fool = MyTopMenuBarItemModel(title: "Fool", imageName: "the_fool", description: "The Fool is a very powerful card in the Tarot deck, usually representing a new beginning -- and, consequently, an end to something in your old life. The Fool's position in your spread reveals which aspects of your life may be subject to change. The Fool portends important decisions ahead which may not be easy to make, and involve an element of risk for you. Approach the changes with optimism and care to gain the most positive outcome.")
        let magician = MyTopMenuBarItemModel(title: "Magician", imageName: "the_magician", description: "The Magician generally associates with intelligent and skillful communicators. His presence in your spread indicates a level of self-confidence and drive which allows you to translate ideas into action. A practical card, the revelations it brings are best applied to the pragmatic and physical aspects of your life, rather then the ephemeral or theoretical. Your success in upcoming ventures in politics or business will likely hinge upon your own strength of will and determination.")
        let highPriestess = MyTopMenuBarItemModel(title: "Priestess", imageName: "the_high_priestess", description: "Your identification with the High Priestess suggests you possess inherent good judgment, in the form of strong intuition. She may indicate that reason should take second place to instinct. Your head must trust in the wisdom of your heart for a change. Yet, she is also an aide by nature, and her presence in certain parts of your spread could be indicative of someone close to you coming to your rescue with their own intuition. ")
        let empress = MyTopMenuBarItemModel(title: "Empress", imageName: "the_empress", description: "Traditionally associated with strong maternal influence, the presence of the Empress is excellent news if you are looking for harmony in your marriage or hoping to start a family. Any artistic endeavours you are currently associated with are also likely to be more successful, as this card often finds those exposed to strong bursts of creative or artistic energy. That creative energy may not be in the form of a painting or art project, however: This card also suggests a very strong possibility of pregnancy -- not necessarily yours, but you might be seeing a new addition to your extended family or the family of a close friend in the near future! This card is a good portent for you and those around you.")
        let emperor = MyTopMenuBarItemModel(title: "Emperor", imageName: "the_emperor", description: "Counterpart to the Empress, the Emperor is signifies a powerful influence, generally male in nature. This can also include concepts in your life historically considered masculine, such as leadership and authority, self-discipline, and stability through the power of action. Its positive influences suggest you may be on a path to advancement or promotion, but it can also be neutral. Often a companion to those destined to take on greater responsibility, it may presage change or loss that necessitates you stepping forward to shoulder a greater burden than you have in the past. Whatever the impetus for the change, it indicates you may possess an uncommon inner strength that will compel you act and to lead.")
        return [fool, magician, highPriestess, empress, emperor]
    }
    
    private var menuDetailsViews: [MyMenuBarItemView] {
        return [MyMenuBarItemView.loadFromXib(),
                MyMenuBarItemView.loadFromXib(),
                MyMenuBarItemView.loadFromXib()
        ]
    }
}

