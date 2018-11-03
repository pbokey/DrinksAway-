//
//  DetailDrinkView.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 11/2/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import UIKit
import Hero

class DetailDrinkView: UIViewController {
    var drink: Drinks?
    
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDescription: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        stackView.isUserInteractionEnabled = true
        drinkImageView.isUserInteractionEnabled = true
        if let realDrink = drink {
            drinkImageView.heroID = realDrink.image
            drinkNameLabel.heroID = realDrink.name
            
            drinkNameLabel.text = realDrink.name
            drinkDescription.text = realDrink.instructions + "Ingredients: " + realDrink.ingredients
            if let url = URL(string: realDrink.image), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                drinkImageView.image = image
            }
            
        }
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(DetailDrinkView.handlePan))
        view.gestureRecognizers = [panRecognizer]
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        print("recognized gesture")
        switch sender.state {
        case .began:
            hero_dismissViewController()
        case .changed:
            let translation = sender.translation(in: nil)
            let progress = translation.y / 2 / view.bounds.height
            Hero.shared.update(progress)
        default:
            Hero.shared.finish()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
