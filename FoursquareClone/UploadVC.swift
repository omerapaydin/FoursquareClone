//
//  UploadVC.swift
//  FoursquareClone
//
//  Created by Ömer on 25.10.2024.
//

import UIKit

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeAt: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc func handleTap() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    @IBAction func next(_ sender: Any) {
        
        if placeName.text != "" && placeType.text != "" && placeAt.text != "" {
            
            if let image = imageView.image {
                var placeModel = PlaceModel.sharedInstance
                placeModel.placeAtmosphere = placeAt.text!
                placeModel.placeName = placeName.text!
                placeModel.placeType = placeType.text!
                placeModel.placeImage = image
                
            }
            performSegue(withIdentifier: "toMap", sender: nil)
            
            
        }else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: .alert)
             let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
      
    }
    
}
