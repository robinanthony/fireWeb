//
//  ViewController.swift
//  fireWeb
//
//  Created by tp on 31/01/2020.
//  Copyright © 2020 univ-orleans. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var data = ["L1","L2","L3","M1","M2","pendu"];
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellule = tableView.dequeueReusableCell(withIdentifier: "uneCellule", for: indexPath);
        cellule.textLabel?.text = data[indexPath.row];
        return cellule;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
    }
}

