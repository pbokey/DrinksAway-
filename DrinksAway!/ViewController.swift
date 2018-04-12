//
//  ViewController.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 4/9/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import UIKit
//import Drinks

class ViewController: UIViewController {

    @IBOutlet weak var drinkImageVIew: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDescriptionText: UITextView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var randomDrink: UIButton!
    
    var drinkImage: UIImage? = nil
    var drinkName: String? = nil
    var drinkDescription: String? = nil
    var drinkIngredients: String? = nil
    
    let globalURLString = "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.gentlemansgazette.com%2Fwp-content%2Fuploads%2F2015%2F01%2FVarious-Liqueur-Based-Cocktails.jpg&f=1"
    
    
    
    @IBAction func randomDrinkButton(_ sender: Any) {
        self.loadingLabel.text = "Loading....."
        
        _ = apiConnection().getRandomDrink() { (tup) in
            self.getInformation(tup)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.updateView()
            })
        }
        
    }
    
    func getInformation(_ vals: [String: String]) -> Void {
        if let url = URL(string: vals["image"]!), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            drinkImage = image
        }
        drinkName = vals["name"]
        drinkDescription = vals["description"]
        drinkIngredients = vals["ingredients"]
    }
    
    func updateView() {
        self.drinkImageVIew.image = drinkImage!
        self.drinkNameLabel.text = drinkName!
        
//        let attrs = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
//        let boldIngredients = NSMutableAttributedString(string: "Ingredients", attributes: attrs)
        
        let fullString = drinkDescription! + "\n Ingredients: \n" + drinkIngredients!
        self.drinkDescriptionText.text = fullString
        
        self.loadingLabel.text = ""
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadingLabel.text = ""
        if let url = URL(string: globalURLString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//            resizeImage(image)
            drinkImageVIew.image = image
            
        }
        
        drinkNameLabel.text = "Choose a random Drink"
        drinkDescriptionText.text = ""
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

