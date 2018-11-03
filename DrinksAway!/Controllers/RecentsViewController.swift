//
//  RecentsViewController.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 5/8/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import UIKit
import Hero

class RecentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var recents: [Drinks] = []
    private var drinkToSend: Drinks?
    // MARK: - Properties
    
    @IBOutlet weak var recentsTableView: UITableView!
    
    // MARK: - Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Create a UITableViewCell for each element in recents
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentDrinkCell", for: indexPath) as! RecentDrinkCell
        
//        cell.contentView.backgroundColor = UIColor.clear
//        let whiteRoundedView: UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 120))
//        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
//        whiteRoundedView.layer.masksToBounds = false
//        whiteRoundedView.layer.cornerRadius = 2.0
//        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        whiteRoundedView.layer.shadowOpacity = 0.2
//        cell.contentView.addSubview(whiteRoundedView)
//        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        
        cell.drinkNameLabel.text = recents[indexPath.row].name
        if let url = URL(string: recents[indexPath.row].image), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            cell.imageView!.image = image
        }
        cell.drinkDescriptionLabel.text = recents[indexPath.row].ingredients
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recentsTableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let drink = recents[row]
        drinkToSend = drink
        self.performSegue(withIdentifier: "detailDrinkView", sender: self)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailDrinkView") {
            let vc = segue.destination as! DetailDrinkView
            if let drink = drinkToSend {
                vc.drink = drink
            }
            vc.heroModalAnimationType = .selectBy(presenting: .zoomSlide(direction: .up), dismissing: .zoomSlide(direction: .down))
        }
    }
    
    func updateRecents(drink obj: Drinks) -> Void {
        // TODO: ensure that the data being passed in is correct and the same format as others in the array
        recents.append(obj)
        // TODO: reload recentsTableView with new drink present at the top
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recents = recieved
        recentsTableView.delegate = self
        recentsTableView.dataSource = self
        view.isUserInteractionEnabled = true
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(RecentsViewController.handlePan))
        view.gestureRecognizers = [panRecognizer]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        print("recognized gesture")
        if (sender.velocity(in: view).x > 0) {
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
