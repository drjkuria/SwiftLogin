//
//  LoginViewController.swift
//  SwiftLogin
//
//  Created by Jonah Kuria on 2016/04/20.
//  Copyright © 2016 kuria. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!



  @IBAction func signIn(sender: AnyObject) {
    loginActivityIndicator.hidden = false
    loginActivityIndicator.startAnimating()

    let username = usernameTextField.text
    let password = passwordTextField.text

    let currentUsername = "admin"
    let currentPassword = "admin"

    func login(username: String, password: String) {
      if (username == currentUsername && password == currentPassword) {
        performSegueWithIdentifier("loginSegue", sender: self)
      }
    }

    if (username != "" && password != "") {
      login(username!, password: password!)
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

}
