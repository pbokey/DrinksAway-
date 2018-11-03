//
//  Drinks.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 4/11/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import Foundation
import UIKit

var recieved: [Drinks] = []

struct Drinks {
    let name: String
    let image: String
    let alcoholic: Bool
    let instructions: String
    let ingredients: String
}

/**
 struct that contains all methods to handle API connection and parseJSON, updateData
 */
struct apiConnection {
    
    let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php")!
    
    /**
     Connects to API to get random drink, handles connection errors
     on a succesful connection and retrieval of data, parses JSON
     Calls self.jsonParser which returns a [String: String]
     this is passed to the completion handler
     
     - Parameter completion: escaping function that takes in a [String: String] dictionary and returs void
    */
    func getRandomDrink(completion: @escaping ([String: String?]) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                let ret = self.jsonParser(jsonData!)
                completion(ret)
            } catch {
                print(error)
                return
            }
        }
        task.resume()
    }
    
    /**
     Takes in JSON from API call and stores relevant information in a dictionary, this method also updates the elements of the TableView which can be found in RecentsViewController
     - Parameter data:a dictionary of [String: Any]
     - Returns: dictionary [String: String] where key are (image, description, and ingredients)
     */
    private func jsonParser(_ data: [String: Any]) -> [String: String?] {
        var ret = [String: String]()
        var ingredients: String = ""
        
        let arr = data["drinks"] as! [Any]
        let dict = arr[0] as! [String: Any]
        
        let name = dict["strDrink"] as? String
        ret["name"] = name
        let image = dict["strDrinkThumb"] as? String
        ret["image"] = image
        let description = dict["strInstructions"] as? String
        
        var count = 0
        for i in 0...14 {
            let x = dict["strIngredient\(i + 1)"] as? String
            if let val = x, val.count > 0 {
                if (count == 0) {
                    ingredients = ingredients + val
                    count += 1
                } else {
                    ingredients = ingredients + ", " + val
                }
            }
        }
        
        ret["description"] = description
        ret["ingredients"] = ingredients
        let drink: Drinks = Drinks(name: name!, image: image!, alcoholic: true, instructions: description!, ingredients: ingredients)
        recieved.insert(drink, at: 0)
        return ret
        
    }
    
}
