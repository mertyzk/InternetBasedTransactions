//
//  UploadViewController.swift
//  InstaFirebaseApplication
//
//  Created by Macbook Air on 18.02.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var uploadButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let imageRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(imageRecognizer)
    }
    

    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("images")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.alertFunc(inputTitle: "ERROR", intputMessage: error?.localizedDescription ?? "upload failed")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        let imgUrl = url?.absoluteString // URL to String
                        print(imgUrl!)
                    }
                }
            }
            
        }
    }
    
    func alertFunc(inputTitle:String,intputMessage:String){
        let alert = UIAlertController(title: inputTitle, message: intputMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
    }
    
}

extension UploadViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func chooseImage(){
        
        let pickerCntrllr = UIImagePickerController()
        pickerCntrllr.delegate = self
        pickerCntrllr.sourceType = .photoLibrary
        pickerCntrllr.allowsEditing = true
        present(pickerCntrllr,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
