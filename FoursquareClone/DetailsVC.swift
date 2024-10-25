//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Ömer on 24.10.2024.
//

import UIKit
import ParseCore

class DetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutButton))
        
    }
 
    
    @objc func addButton(){
        
        performSegue(withIdentifier: "toDetail", sender: nil)
        
    }
    
    @objc func logoutButton(){
        
        PFUser.logOutInBackground { (error) in
            if error != nil{
                print("error")
            }else {
                self.performSegue(withIdentifier: "logoutVC", sender: nil)
            }
        }
        
        
        
    }
    
    
    
    
    
    
}
