//
//  ViewController.swift
//  File 2
//
//  Created by Sanzid Ashan on 5/14/16.
//  Copyright © 2016 Sanzid Ashan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
  
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    
        
        print("Logged in..")
        self.performSegue(withIdentifier: "aa", sender: NewViewController.self)

        
    }

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
        // TODO: Change where the log in button is positioned in your view
        //logInButton.frame = CGRectMake(39, 455, 238, 43)
        
        // self.view.addSubview(logInButton)
        
        
        
        if (FBSDKAccessToken.current() == nil)
        {
            print("Not logged in..")
        }
        else
        {
            print("Logged in..")
            self.performSegue(withIdentifier: "aa", sender: NewViewController.self)
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        //loginButton.frame = CGRectMake(39, 391, 238, 43)
        loginButton.delegate = self
        //self.view.addSubview(loginButton)
        
        
        
        
        
        if UserDefaults.standard.value(forKey: "uid") != nil && CURRENT_USER.authData != nil
        {
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginAction(_ sender: AnyObject) {
        
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != ""
        {
            FIREBASE_REF?.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error == nil
                {
                    UserDefaults.standard.setValue(authData?.uid, forKey: "uid")
                    print("Logged In :)")
                    self.performSegue(withIdentifier: "aa", sender: NewViewController.self)
                    
                    
                    
                }
                else
                {
                    print(error)
                }
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password.", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            print("Login complete.")
            self.performSegue(withIdentifier: "aa", sender: NewViewController.self)
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -100, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -100, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    
}




