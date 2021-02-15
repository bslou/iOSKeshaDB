//
//  ViewController.swift
//  Test
//
//  Created by Benjamin Sloutsky on 2/13/21.
//

import UIKit
import iOSKeshaDB

class ViewController: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var weight: UITextField!
    var keshadb: KeshaDB? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        keshadb = KeshaDB()
        // Do any additional setup after loading the view.
        if keshadb!.exists(at: "nomnom"){
            keshadb!.access(name: "nomnom")
            //keshadb.addRow(key: "name", arr: ["120", "130", "12", "105"])
            //var o = (keshadb.data[keshadb.vals[1]]) as! Array<Any>
            //o[1] = "Riley"
            //keshadb.data[keshadb.vals[1]] = o
            //print("this thing = \(keshadb.data[keshadb.vals[1]])")
            //keshadb.update()
        }else{
            keshadb!.store(arr: ["name", "age", "height"], name: "nomnom")
        }
            
        
        
        
    }

    @IBAction func clicked(_ sender: Any) {
        
        keshadb!.add(arr: [name.text!, age.text!, weight.text!])
        print(keshadb!.printDBRes())
        performSegue(withIdentifier: "soon", sender: self)
    }
    
}

