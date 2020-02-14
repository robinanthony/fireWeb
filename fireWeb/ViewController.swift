//
//  ViewController.swift
//  fireWeb
//
//  Created by tp on 31/01/2020.
//  Copyright © 2020 univ-orleans. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableViewMonuments: UITableView!
    
    var monumentsTitre = [String]()
    var monumentsDescription = [String]()
    
    var data = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewMonuments.delegate = self
        tableViewMonuments.dataSource = self
        print("Delegate et DataSource ok !")
        
        
        let url = URL(string: "http://eddbali.net/files/iOS/Documents/monuments.json")
        
        Alamofire.request(url!, method: .get).responseJSON { (reponse) in
            
            if reponse.result.isSuccess {
                let contenuJSON : JSON = JSON(reponse.result.value!)
                self.data = contenuJSON
                self.majMonuments(self.data)
                self.tableViewMonuments.reloadData()
                print("Affichage réussie ! ")
                // print(contenuJSON)
            } else {
                print("Erreur : \(reponse.result.error!)")
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monumentsTitre.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellule = tableView.dequeueReusableCell(withIdentifier: "uneCellule", for: indexPath)
        
        cellule.textLabel?.text = monumentsTitre[indexPath.row]
        cellule.detailTextLabel?.text = monumentsDescription[indexPath.row]
        return cellule
    }
    
    private func majMonuments(_ data : JSON){
        for cat in data["categories"].arrayValue {
            for monuments in cat["monuments"].arrayValue {
//                titre.append(monuments["titre"].stringValue)
//                print(monuments["titre"])
            self.monumentsTitre.append(monuments["titre"].stringValue)
            self.monumentsDescription.append(monuments["description"].stringValue)
            }
        }
    }
}

