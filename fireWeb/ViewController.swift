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
    
    var categorie = [String]()
    
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
                self.categorie = self.lesTitres(self.data)
                self.tableViewMonuments.reloadData()
                print("Affichage réussie ! ")
                // print(contenuJSON)
            } else {
                print("Erreur : \(reponse.result.error!)")
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorie.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellule = tableView.dequeueReusableCell(withIdentifier: "uneCellule", for: indexPath)
        
        cellule.textLabel?.text = categorie[indexPath.row]
        return cellule
    }
    
    private func lesTitres(_ data : JSON) -> [String] {
        
        var titre = [String]()
        
        for elt in data["categories"].arrayValue {
            titre.append(elt["titre"].stringValue)
        }
        return titre
    }
    
}

