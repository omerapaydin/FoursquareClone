//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Ömer on 24.10.2024.
//

import UIKit
import ParseCore


class ViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    
        
    }

    @IBAction func signIn(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user, error) in
                if user != nil {
                    
                    self.performSegue(withIdentifier: "goTo", sender: nil)
                    
                }else{
                    self.makeAlert(title: "error", message: error?.localizedDescription ?? "Error")
                }
            }
            
            
        }
        
    }
    
    
    
    @IBAction func signUp(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            
            user.username = usernameText.text
            user.password = passwordText.text
            
            
            user.signUpInBackground { (success, error) in
                
                if success {
                    self.performSegue(withIdentifier: "goTo", sender: nil)
                    
                } else {
                    self.makeAlert(title: "error", message: error?.localizedDescription ?? "Error")
                }
            }
        }
    }
    
    
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

