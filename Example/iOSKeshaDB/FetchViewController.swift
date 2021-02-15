//
//  FetchViewController.swift
//  Test
//
//  Created by Benjamin Sloutsky on 2/13/21.
//

import UIKit
import iOSKeshaDB

class FetchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return keshadb.DBCount()
    }
    let keshadb = KeshaDB()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = keshadb.findAt(row: indexPath.row, column: 1)
        return cell
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            keshadb.removeRow(row: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    @IBOutlet weak var tableVie: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if keshadb.exists(at: "nomnom"){
            keshadb.access(name: "nomnom")
        }
        
        print("Count = \(keshadb.DBCount())")
        // Do any additional setup after loading the view.
        tableVie.delegate = self
        tableVie.dataSource = self
    }
    

    

}
