//
//  ViewController.swift
//  InstaFirebaseApplication
//
//  Created by Macbook Air on 18.02.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }

    @IBAction func signInButton(_ sender: Any) {
        
        if emailTextField.text != nil && emailTextField.text != "" && passwordTextField.text != nil && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil{
                    self.alertFunc(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            alertFunc(titleInput: "ERROR!", messageInput: "Username/Pass?")
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if emailTextField.text != nil && emailTextField.text != "" && passwordTextField.text != nil && passwordTextField.text != ""{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil{
                    self.alertFunc(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            alertFunc(titleInput: "ERROR!", messageInput: "Username/Pass?")
        }
    }
    
}

extension ViewController{
    func alertFunc(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(okButton)
    }
}
