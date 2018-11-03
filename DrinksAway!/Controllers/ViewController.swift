//
//  ViewController.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 4/9/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import UIKit
//import Drinks
import Hero

class ViewController: UIViewController {

    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDescriptionText: UITextView!
//    @IBOutlet weak var loadingLabel: UILabel!
    
    var drinkImage: UIImage?
    var drinkName: String?
    var drinkDescription: String?
    var drinkIngredients: String?
    
    let globalURLString = "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.gentlemansgazette.com%2Fwp-content%2Fuploads%2F2015%2F01%2FVarious-Liqueur-Based-Cocktails.jpg&f=1"
    
    @IBAction func showRecents(_ sender: Any) {
        self.performSegue(withIdentifier: "showRecents", sender: sender)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecents" {
            let vc = segue.destination as! RecentsViewController
            vc.heroModalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        }
    }
    
    
    @IBAction func randomDrinkButton(_ sender: UIButton) {
        sender.pulsate()
//        self.loadingLabel.text = "Loading....."
        
        _ = apiConnection().getRandomDrink() { (tup) in
            self.getInformation(tup)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.updateView()
            })
        }
    }
    
    func getInformation(_ vals: [String: String?]) -> Void {
        guard let imageURL = vals["image"] else {
            return
        }
        if let url = URL(string: imageURL ?? globalURLString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            drinkImage = image
        }
        drinkName = vals["name"] ?? "NAME"
        drinkDescription = vals["description"] ?? "DESCRIPTION"
        drinkIngredients = vals["ingredients"] ?? "INGREDIENTS"
    }
    
    func updateView() {
        self.drinkImageView.image = drinkImage!
        self.drinkNameLabel.text = drinkName!
        
        let fullString = drinkDescription! + "\n Ingredients: \n" + drinkIngredients!
        self.drinkDescriptionText.text = fullString
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.loadingLabel.text = ""
        if let url = URL(string: globalURLString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//            resizeImage(image)
            drinkImageView.image = image

        }
        
        drinkNameLabel.text = "Choose a random Drink"
        drinkDescriptionText.text = ""
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

