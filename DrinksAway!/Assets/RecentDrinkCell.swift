//
//  RecentDrinkCell.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 5/8/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import UIKit
import Hero

class RecentDrinkCell: UITableViewCell {

    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDescriptionLabel: UILabel!
    
    var drink: Drinks? {
        didSet {
            if let url = URL(string: (drink?.image)!), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                drinkImage.image = image
            }
            drinkNameLabel.text = drink?.name
            drinkDescriptionLabel.text = drink?.ingredients
            
            drinkImage.heroID = drink?.image
            drinkNameLabel.heroID = drink?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
