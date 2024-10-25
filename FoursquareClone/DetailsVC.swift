//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Ömer on 24.10.2024.
//

import UIKit
import ParseCore

class DetailsVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var selectedPlaceId = ""
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutButton))
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShow"{
            let desc = segue.destination as! ShowVC
            desc.chosenPlaceId = selectedPlaceId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toShow", sender: nil)
        
    }
    
    
    func getData(){
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                print("error")
            }else{
                if objects != nil{
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    
                    
                    for object in objects!{
                       if let placeName = object["name"] as? String{
                           if let placeId = object.objectId {
                               self.placeNameArray.append(placeName)
                               self.placeIdArray.append(placeId)
                           }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
        
    }
   
    
    
    
    
    
    
}
