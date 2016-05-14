//
//  LoginViewController.swift
//  SwiftLogin
//
//  Created by Jonah Kuria on 2016/04/20.
//  Copyright © 2016 kuria. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func signIn(sender: AnyObject) {
        loginActivityIndicator.hidesWhenStopped = true
        loginActivityIndicator.hidden = false
        loginActivityIndicator.startAnimating()
        
        let username = usernameTextField.text
        let password = passwordTextField.text

        let currentUsername = "admin"
        let currentPassword = "admin"
        
        func login(username: String, password: String) {
            if (username == currentUsername && password == currentPassword) {
                print("Valid login for user \(username)")
                performSegueWithIdentifier("loginSegue", sender: self)
                fetchToken()
            } else {
                print("Failed login for user \(username)")
                displayError("Invalid credentials");
            }
            loginActivityIndicator.stopAnimating()
        }
        
        login(username!, password: password!)
    }
    
    // fetch auth token
    let url: String = "http://userservice.staging.tangentmicroservices.com/api-token-auth/"
    let parameters = ["username": "admin", "password": "admin"]
    
    var auth_token: JSON = []
    
    func fetchToken() {
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { response in
                print(response.request)
                print(response.response)
                print(response.data)
                print(response.result)
                
                if let value = response.result.value {
                    let token = JSON(value)
                    self.auth_token = token["token"]
                    print("Token: \(self.auth_token)")
                }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.secureTextEntry = true
        loginActivityIndicator.hidden = true
        loginActivityIndicator.hidesWhenStopped = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func displayError(message:String) {
        let myAlert = UIAlertController(title:"Error", message:message, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default, handler:nil);
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
    }
}
